source "https://rubygems.org"

ruby "2.2.2"

gem 'rails', '4.2.4'

gem 'rails-api'

gem 'spring', :group => :development

gem 'pg'
gem 'rack-cors', :require => 'rack/cors'
gem 'thin'

# authentication
gem 'devise_token_auth'
gem 'omniauth'

group :test do
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'json-schema'
end

group :development, :test do
  gem "awesome_print"
  gem "dotenv-rails"
  gem "pry"
  gem "pry-nav"
  gem "rspec-rails", "~> 3.0"
end

gem 'mandrill-api'
gem 'mandrill_mailer'
gem 'excon'

# To use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano', :group => :development

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
