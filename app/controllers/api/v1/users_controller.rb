class Api::V1::UsersController < Api::V1::BaseController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_api_v1_user
      redirect_to :back, :alert => "Access denied."
    end

    render json: {user: @user}
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])

 		respond_to do |format|
      if @user.update_attributes(params[:user])
        format.json { head :no_content }
      else
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
 		end
  end

end
