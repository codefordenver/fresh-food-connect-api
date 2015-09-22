class Api::V1::LocationsController < Api::V1::BaseController
  before_action :ensure_owner_of_resource, except: [:list]
  before_action :ensure_admin_user, only: [:list]


  # /api/{version}/users/:user_id/locations
  def index
    render json: current_user.locations, status: :ok
  end

  # / api/:version/users/:user_id/locations/:location_id
  def show
    @location = current_user.locations.find(params[:id])
    render json: @location, status: :ok
  end

  # /api/:version/users/:user_id/location
  def create
    @location = current_user.locations.build(location_params)
    if @location.save
      render json: @location, status: :created
    else
      render json: { errors: @location.errors }, status: :unprocessable_entity
    end
  end

  def update
    #locations determined by :check_user_access
    location = current_user.locations.find(params[:id])
    if location.update_attributes(location_params)
      render json: location, status: :ok
    else
      render json: { errors: location.errors }, status: :unprocessable_entity
    end
  end

  # /api/:version/users/:user_id/locations/:location_id
  def destroy
    @location = current_user.locations.find(params[:id])
    if @location.destroy
      head :no_content
    else
      render json: { errors: @location.errors }, status: 422
    end
  end

  # Admin route

  def list
    render json: Location.all, status: :ok
  end

  private

  def location_params
    params.require(:location).permit(:address,
                                     :city,
                                     :state,
                                     :zipcode,
                                     :comments,
                                     :extra,
                                     :route_id,
                                     :latitude,
                                     :longitude,
                                     :pickup_date,
                                     :created_at,
                                     :updated_at,
                                     :user_id)
  end

end
