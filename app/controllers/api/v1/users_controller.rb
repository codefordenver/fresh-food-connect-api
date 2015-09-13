class Api::V1::UsersController < Api::V1::BaseController
  before_action :admin_access_required, only: [:index]

  def index
    users = []
    User.all.order(:id).each{|u| users << sanitize_user_attributes(u)}

    render json: users
  end

  def show
    user = User.find(params[:id])
    unless user == current_api_v1_user
      redirect_to :back, :alert => "Access denied."
    end

    render json: {user: user}
  end

  def create
    # user = User.new(params[:user])

    # respond_to do |format|
    #   if user.save
    #     format.json { render :json => user, :status => :created, :location => user }
    #   else
    #     format.json { render :json => user.errors, :status => :unprocessable_entity }
    #   end
    # end
  end

  def update
   #  user = User.find(params[:id])

 		# respond_to do |format|
   #    if user.update_attributes(params[:user])
   #      format.json { head :no_content }
   #    else
   #      format.json { render :json => user.errors, :status => :unprocessable_entity }
   #    end
 		# end
  end


  private

  def sanitize_user_attributes(u)
    user_attributes = u.attributes
    user_attributes.delete("provider")
    user_attributes.delete("encrypted_password")
    user_attributes.delete("reset_password_token")
    user_attributes.delete("reset_password_sent_at")
    user_attributes.delete("remember_created_at")
    user_attributes.delete("sign_in_count")
    user_attributes.delete("current_sign_in_at")
    user_attributes.delete("last_sign_in_at")
    user_attributes.delete("current_sign_in_ip")
    user_attributes.delete("last_sign_in_ip")
    user_attributes.delete("confirmation_token")
    user_attributes.delete("confirmed_at")
    user_attributes.delete("confirmation_sent_at")
    user_attributes.delete("unconfirmed_email")
    user_attributes.delete("tokens")
    user_attributes.delete("created_at")
    user_attributes.delete("updated_at")

    user_attributes
  end

  def admin_access_required
    if current_user.admin? == false
      render json: {error: "Access denied."}
      return
    end
  end

end
