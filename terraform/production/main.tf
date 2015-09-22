# Set Atlas Configuration
atlas {
    name = "codefordenver/freshfoodconnect-production"
}

# Import Digital Ocean Module
module "digitalocean" {
  source = "../module-digitalocean"
}

# Create Production Postgres Droplet
module "postgres" {
  source = "../module-postgres"

  name = "postgres.prod.ffc"
  backups = "true"
}
