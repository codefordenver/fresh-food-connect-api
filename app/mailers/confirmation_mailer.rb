class ConfirmationMailer < MandrillMailer::TemplateMailer
  default from: 'support@freshfoodconnect.org'

  def send_confirmations(users)
    users = Array.wrap(users) # in case you pass a single user object
    emails = users.map{|user| {email: user.email, name: "#{user.first} #{user.last}"}}

    mandrill_mail(
      template: 'Donation Reminder',
      to: emails,
        # to: invitation.email,
        # to: { email: invitation.email, name: 'Honored Guest' },
      # vars: {
      #   'OWNER_NAME' => invitation.owner_name,
      #   'PROJECT_NAME' => invitation.project_name
      # },
      important: true,
      inline_css: true,
      recipient_vars: users.map do |user|
        { user.email =>
          {
            "FIRST_NAME" => user.first,
            "USER_URL" => "/users"
          }
        }
      end
     )
  end
end