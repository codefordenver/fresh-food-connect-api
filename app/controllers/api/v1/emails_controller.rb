class Api::V1::EmailsController < Api::V1::BaseController
  before_action :ensure_admin_user

  # params: user_id and location_id
  def send_reminders
    uids = format_array(params[:user_id])
    lids = format_array(params[:location_id])
  	if uids.present?
      locations = Location.joins(:user).where('users.id IN(?)', uids)
    elsif lids.present?
      locations = Location.where(id: lids)
    else
      locations = Location.all
    end
    ConfirmationMailer.send_confirmation(locations).deliver
    head 204
  end

  def format_array(val)
    if val.is_a?(String)
      val.split(",").map(&:strip)
    elsif val.is_a?(Array)
      val
    else
      []
    end
  end
end