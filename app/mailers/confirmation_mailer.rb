class ConfirmationMailer < MandrillMailer::TemplateMailer
  default from: ENV['FROM_EMAIL_ADDRESS']

  def send_confirmation(users)
    users = Array.wrap(users) # in case you pass a single user object
    emails = users.map{|user| {email: user.email, name: "#{user.first} #{user.last}"}}

    mandrill_mail(
      template: 'Donation Reminder',
      to: emails,
      important: true,
      inline_css: true,
      recipient_vars: users.map do |user|
        location_id = user.locations.first.try(:id) # in case for some reason user doesnt have any locations, this will just return nil instead of erroring
        { user.email =>
          {
            "FIRST_NAME" => user.first,
            "USER_YES_DONATION_URL" => confirm_yes_url(user.id, location_id),
            "USER_NO_DONATION_URL" => confirm_no_url(location_id)
          }
        }
      end
     )
  end

  # I realize this isn't great but rails url helpers aren't available here
  # so I'm just hacking this together until a more elegant solution can be figured out post pilot
  def confirm_yes_url(user_id, location_id)
    default_host + "/confirm-donation?location_id=#{location_id}"
  end

  def confirm_no_url(location_id)
    default_host + "/sorrynotthistime?location_id=#{location_id}"
  end

  def default_host
    "www." + ActionMailer::Base.default_url_options[:host].to_s
  end
end