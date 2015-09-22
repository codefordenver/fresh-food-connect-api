class Api::V1::EmailsController < Api::V1::BaseController
  before_action :ensure_admin_user

  def send_welcome
  	users = User.all
    ConfirmationMailer.send_confirmations(users).deliver
  end
end