class ConfirmationMailer < MandrillMailer::TemplateMailer

  def send_confirmation(users)
    users = Array.wrap(users) # in case you pass a single user object
    emails = users.map{|user| {email: user.email, name: "#{user.first} #{user.last}"}}

    mandrill_mail(
      template: 'Donation Reminder',
      to: emails,
      important: true,
      inline_css: true,
      recipient_vars: users.map do |user|
        { user.email =>
          {
            "FIRST_NAME" => user.first,
            "USER_YES_DONATION_URL" => confirm_yes_url(user.id),
            "USER_NO_DONATION_URL" => confirm_no_url
          }
        }
      end
     )
  end

  # I realize this isn't great but rails url helpers aren't available here 
  # so I'm just hacking this together until a more elegant solution can be figured out post pilot
  def confirm_yes_url(user_id)
    default_host + "/users/#{user_id}/donations/new"
  end

  def confirm_no_url
    default_host + "/sorrynotthistime"
  end

  def default_host
    ActionMailer::Base.default_url_options[:host]
  end
end