class Api::V1::UsersController < Api::V1::BaseController
  before_action :ensure_admin_user, only: [ :index ]

  def index
      users = User.all.order(:id)
      render json: users, serializer: UserSerializer
  end

  def show
      raise Exceptions::AuthorizationError unless params[:id].to_i == current_user.id
      user = User.find(params[:id])
      render json: user, serializer: UserSerializer
  end

end
