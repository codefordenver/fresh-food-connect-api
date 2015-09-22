class Api::V1::DonationsController < Api::V1::BaseController

  before_action :ensure_admin_user, only: :list
  before_action :ensure_owner_of_resource, only: [:index, :update]

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
    donation = current_user.donations.build donation_params
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
      render json: Donation.with_quantity.within_time_range(params[:from], params[:to]), status: :ok
    rescue RangeError => error
      raise Exceptions::QueryError "Invalid Query String: #{error.message}"
    end
  end

  private 

  def donation_params
    params.require(:donation).permit(:location_id, :user_id, :size, :comments)
  end
end
