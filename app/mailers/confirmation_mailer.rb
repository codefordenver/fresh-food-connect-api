class ConfirmationMailer < MandrillMailer::TemplateMailer
  default from: 'support@freshfoodconnect.org'

  def confirm
    users = User.all
    emails = users.map{|user| {email: user.email, name: "#{user.first} #{user.last}"}}

    mandrill_mail(
      template: 'ffc-donation',
      subject: I18n.t('invitation_mailer.invite.subject'),
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
            "USER_URL" => user_url(user)
          }
        }
      end
     )
  end
end