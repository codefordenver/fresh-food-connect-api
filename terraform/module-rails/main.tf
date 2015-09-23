variable "name" {}

# Reference Rails Artifact in Atlas
resource "atlas_artifact" "rails" {
  name = "codefordenver/freshfoodconnect-rails"
  type = "digitalocean.image"
}

# Create Rails Droplet in NYC3
resource "digitalocean_droplet" "rails" {
  image = "${atlas_artifact.rails.id}"
  name = "${var.name}"
  region = "nyc3"
  size = "512mb"
}