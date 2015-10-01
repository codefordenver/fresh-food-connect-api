# Install Postgres
sudo apt-get install -y postgresql postgresql-contrib

echo "CREATE ROLE $POSTGRES_USER WITH LOGIN PASSWORD '$POSTGRES_PASSWORD';" | sudo -i -u postgres psql
sudo -i -u postgres createdb --owner=$POSTGRES_USER $POSTGRES_ENV

# user_name=demo_user
# password=pass1
# echo "CREATE ROLE $user_name WITH LOGIN PASSWORD '$password';" | sudo -i -u postgres psql
# sudo -i -u postgres createdb --owner=$user_name demo_rails_app_app


#sudo -u postgres psql postgres postgres -c "ALTER USER postgres WITH ENCRYPTED PASSWORD 'postgres'"
# Switch to Postgres User
# sudo -i -u postgres
