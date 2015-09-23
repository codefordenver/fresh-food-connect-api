# Set Atlas Configuration
atlas {
    name = "codefordenver/freshfoodconnect-production"
}

# Import AWS Route 53 Module
module "route53" {
  source= "../module-route53"
}

# Import Digital Ocean Module
module "digitalocean" {
  source = "../module-digitalocean"
}

# Create Production Rails Droplet
module "rails" {
	source = "../module-rails"

	name = "rails.prod.ffc"
	create_before_destroy = true
}

# Create Production Postgres Droplet
module "postgres" {
  source = "../module-postgres"

  name = "postgres.prod.ffc"
  backups = "true"
  create_before_destroy = true
}
