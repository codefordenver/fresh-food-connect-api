class ConfirmationMailer < MandrillMailer::TemplateMailer
  default from: ENV['FROM_EMAIL_ADDRESS']

  def send_confirmation(locations)
    locations = Array.wrap(locations) # in case you pass a single location object
    emails = locations.map{|l| l.user.email}

    mandrill_mail(
      template: 'Donation Reminder',
      to: emails,
      important: true,
      inline_css: true,
      recipient_vars: locations.map do |location|
        # not sure how the following will map to the above :to email addresses if there are more than one locations per user email
        # a better alternative to ensure the emails get sent in that scenario is to send the emails individually in a background worker
        # but I don't know what the deployment situation is so am uncertain about ensuring sidekiq gets started and stays running
        { location.user.email =>
          {
            "USER_YES_DONATION_URL" => confirm_yes_url(location.id),
            "USER_NO_DONATION_URL" => confirm_no_url(location.id)
          }
        }
      end
     )
  end

  # I realize this isn't great but rails url helpers aren't available here
  # so I'm just hacking this together until a more elegant solution can be figured out post pilot
  def confirm_yes_url(location_id)
    default_host + "/confirm-donation?location_id=#{location_id}"
  end

  def confirm_no_url(location_id)
    default_host + "/sorrynotthistime?location_id=#{location_id}"
  end

  def default_host
    "http://www." + ActionMailer::Base.default_url_options[:host].to_s
  end
end