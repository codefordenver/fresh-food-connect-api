# Install Postgres
sudo apt-get install -y postgresql postgresql-contrib

# Persist environment variables set by Packer for use
# when the user is switched from root to postgres
sudo echo 'Defaults env_keep += "POSTGRES_USER POSTGRES_PASSWORD POSTGRES_ENV"' >> /etc/sudoers

# Create the postgres user with the password set as an environment variable.
# The normal environment variable access ($ENV_VAR) didn't work so I had to
# use echo and printenv, this is far more verbose and convuluted than it 
# should be.
sudo -i -u postgres echo "CREATE ROLE `printenv POSTGRES_USER` WITH LOGIN PASSWORD '`printenv POSTGRES_PASSWORD`';" > sudo -i -u postgres psql

# Currently, this is a weird edge case I still have not figured out.
# While echo and printenv work for accessing the environment variables above,
# they do not work when supplied to createdb.
# For now they are hardcoded. I would like for them to be parameterized off of
# environment variables. It's okay temporarily because these two variables 
# aren't password or key information.
sudo -i -u postgres createdb --owner=postgres ffc_production