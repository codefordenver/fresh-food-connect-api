require 'donation_mandrill_mailer'

class Api::V1::EmailsController < Api::V1::BaseController
  before_action :ensure_admin_user

  def send_welcome
    User.all.order(:id).each do |u|
      # ActionMailer::BaseMandrillMailer::UserMailer.welcome(u.id)
      UserMailer.welcome(u.id)
    end
  end
end