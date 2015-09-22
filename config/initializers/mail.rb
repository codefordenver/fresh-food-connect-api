ActionMailer::Base.smtp_settings = {
  :address   => "smtp.mandrillapp.com",
  :port      => 587,
  :user_name => ENV['MANDRILL_USERNAME'],
  :password  => ENV['MANDRILL_API_KEY'],
  :domain    => ENV['SMTP_DOMAIN']
}
ActionMailer::Base.default_url_options = { host: ENV['SMTP_DOMAIN'] }
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default :from => ENV['FROM_EMAIL_ADDRESS']