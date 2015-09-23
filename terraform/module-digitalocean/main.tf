output "ssh_keys" {
	value = ["${digitalocean_ssh_key.ssh_key.fingerprint}"]
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
}

# Register SSH Key
resource "digitalocean_ssh_key" "ssh_key" {
    name = "Code for Denver SSH Key"
    public_key = "${file("${path.module}/cfd_rsa.pub")}"
}