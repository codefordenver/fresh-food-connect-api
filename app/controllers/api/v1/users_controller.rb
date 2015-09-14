class Api::V1::UsersController < Api::V1::BaseController
  # before_action :admin_access_required, only: [:index]

  def index
    if current_user.admin?
      users = []
      User.all.order(:id).each{|u| users << sanitize_user_attributes(u)}

      render json: {users: users}
    else
      render json: {errors: "access denied"}, status: 403
    end
  end

  def show
    user = User.where(id:params[:id]).first

    if current_user.admin? ||  user == current_user
      render json: {user: sanitize_user_attributes(user)}
    else
      render json: {errors: "access denied"}, status: 403
    end
  end
  
  def create
    # handled by Devise Token Auth
  end

  def update
   # handled by Devise Token Auth
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

    user_attributes["role"] = u.role

    user_attributes
  end

end
