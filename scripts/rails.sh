# Add the RVM Repository
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt-get -y update
sudo apt-get -y install rvm

# Install Ruby 2.2.2
rvm install ruby-2.2.2
rvm --default use ruby-2.2.2

# Install Bundler
gem install bundler --no-rdoc --no-ri

# Install NodeJS for Rails Asset Compiler
sudo apt-get install -y nodejs && sudo ln -sf /usr/bin/nodejs /usr/local/bin/node
