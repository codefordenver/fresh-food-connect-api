class Api::V1::DonationsController < Api::V1::BaseController

  before_action :ensure_admin_user, only: :list
  before_action :ensure_owner_of_resource, only: [:index, :update]

  skip_action :authenticate!, only: :create
  before_action :authenticate_with_token, only: :create

  # Donor, Admin
  # Lists all of the donations for a given user
  # /api/:version/users/:user_id/donations
  # optional location_id query param to filter down by location
  def index
    if params[:location_id]
      render json: current_user.donations.where(location_id: params[:location_id]), status: :ok
    else
      render json: current_user.donations, status: :ok
    end
  end

  # Donor
  # Creates a new donation resource
  # /api/:version/users/:user_id/donations
  def create
    u = @user || current_user
    donation = u.donations.build donation_params
    if donation.save
      render json: donation, status: :created
    else
      render json: donation.errors, status: :unprocessable_entity
    end
  end

  # Donor, Admin
  # Allows for the update of donation information, specifically size and comments
  # /api/:version/users/:user_id/donations/:id
  def update
    donation = current_user.donations.find(params[:id])
    if donation.update(donation_params)
      render json: donation, status: :ok
    else
      render json: { errors: donation.errors }, status: :unprocessable_entity
    end

  end

  # Admin Only
  # Returns a list of all donations
  # /api/:version/donations?from=DateTime&to=DateTime
  def list
    begin
      donations = Donation.with_quantity.within_time_range(params[:from], params[:to]).includes(:location)
      locations = donations.map(&:location)
      render json: {donations: donations, locations: locations}, status: :ok
    rescue RangeError => error
      raise Exceptions::QueryError "Invalid Query String: #{error.message}"
    end
  end

  private 

  def authenticate_with_token
    if params[:token]
      dt = DonationToken.find_by(token: token)
      if dt and !dt.expired?
        @user = dt.user
      else
        return render json: {errors: ["Invalid credentials"]}, status: 401
      end
    else
      authenticate!
    end
  end

  def donation_params
    params.require(:donation).permit(:location_id, :user_id, :size, :comments)
  end
end
