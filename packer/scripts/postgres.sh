# Install Postgres
sudo apt-get install -y postgresql postgresql-contrib

# Create the Postgres User Role
sudo -u postgres psql postgres postgres -c "ALTER USER postgres WITH ENCRYTPED PASSWORD 'postgres'"

# Switch to Postgres User
sudo -i -u postgres
