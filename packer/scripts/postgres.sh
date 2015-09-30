# Install Postgres
sudo apt-get install -y postgresql postgresql-contrib

# Create the Postgres User Role
su - postgres
create role rails with createdb login password 'rails';

#sudo -u postgres psql postgres postgres -c "ALTER USER postgres WITH ENCRYPTED PASSWORD 'postgres'"
# Switch to Postgres User
# sudo -i -u postgres
