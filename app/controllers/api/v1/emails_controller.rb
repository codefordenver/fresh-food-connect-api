class Api::V1::EmailsController < Api::V1::BaseController
  before_action :ensure_admin_user

  def create
  	users = User.all
    ConfirmationMailer.send_confirmation(users).deliver
  end
end