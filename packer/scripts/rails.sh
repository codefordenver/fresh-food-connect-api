# Add the RVM Repository, Install, and Source RVM
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt-get -y update
sudo apt-get -y install rvm
source /etc/profile.d/rvm.sh

# Install Ruby 2.2.2
rvm install ruby-2.2.2
rvm --default use ruby-2.2.2

# Install Bundler
gem install bundler --no-rdoc --no-ri

# Install NodeJS for Rails Asset Compiler
sudo apt-get install -y nodejs && sudo ln -sf /usr/bin/nodejs /usr/local/bin/node

# Install PostgreSQL Client for PG Gem
sudo apt-get -y install libpq-dev

# Install Dependencies
cd /ops/app
bundle install --without development test

# Compile Rails Assets and Run Database Migrations
bundle exec rake assets:precompile db:migrate

# Start Thin
bundle exec thin start