resource "digitalocean_tag" "cluster_tag" {
  name = "${var.name}"
}

resource "digitalocean_ssh_key" "cluster_ssh_key" {
  name       = "${var.name}-key"
  public_key = "${file(var.ssh_key)}"
}

resource "digitalocean_droplet" "cluster_droplets" {
  name = "${var.name}-node${count.index}"
  image = "ubuntu-22-04-x64"
  size = "${var.instance_size}"
  region = "nyc1"
  ssh_keys = ["${digitalocean_ssh_key.cluster_ssh_key.id}"]
  count = "${var.servers}"
  tags = ["${digitalocean_tag.cluster_tag.id}"]

  lifecycle {
	  prevent_destroy = false
  }

  connection {
    timeout = "30s"
  }
}
