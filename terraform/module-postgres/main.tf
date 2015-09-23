variable "name" {}
variable "backups" {}
variable "ssh_keys" {}

# Reference Postgres Artifact in Atlas
resource "atlas_artifact" "postgres" {
  name = "codefordenver/freshfoodconnect-postgres"
  type = "digitalocean.image"
}

# Create Postgres Droplet in NYC3
resource "digitalocean_droplet" "postgres" {
  image = "${atlas_artifact.postgres.id}"
  name = "${var.name}"
  region = "nyc3"
  size = "512mb"
  ssh_keys = ["${var.ssh_keys}"]

  lifecycle {
  	create_before_destroy = true
  }
}