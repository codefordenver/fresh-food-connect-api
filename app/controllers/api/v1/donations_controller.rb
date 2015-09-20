class Api::V1::DonationsController < Api::V1::BaseController

  before_action :ensure_admin_user, only: :list
  before_action :ensure_owner_of_resource, only: [:index, :update]

  # Donor, Admin
  # Lists all of the donations for a given user
  # /api/:version/users/:user_id/locations/:location_id/donations
  def index
    render json: current_user.donations.where(params.permit(:location_id)), status: :ok
  end

  # Donor
  # Creates a new donation resource
  # /api/:version/users/:user_id/locations/:location_id/donations
  def create
    donation = Donation.new(params.permit(:location_id, :user_id, :size, :comments))
    if donation.valid?
      donation.save
    else
      render json: donation.errors, status: :unprocessable_entity
    end

    render json: donation, status: :created

  end

  # Donor, Admin
  # Allows for the update of donation information, specifically size and comments
  # /api/:version/users/:user_id/locations/:location_id/donations/:id
  def update
    donation = Donation.find(params[:id])
    if donation.update(params.permit(:size, :comments))
      head :no_content
    else
      render json: { errors: donation.errors }, status: :unprocessable_entity
    end

  end

  # Admin Only
  # Returns a list of all donations
  # /api/:version/donations?from=DateTime&to=DateTime
  def list
    begin
      render json: Donation.within_time_range(params[:from], params[:to]), status: :ok
    rescue RangeError => error
      raise Exceptions::QueryError "Invalid Query String: #{error.message}"
    end
  end

end
