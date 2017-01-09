# Create a new SSH key
resource "digitalocean_ssh_key" "dock" {
    name = "Terraform Dock Test"
    public_key = "${file("~/.ssh/id_rsa.pub")}"
}

# Template for user_data
data "template_file" "user_data" {
    template = "${file("user_data.tpl")}"
    vars { }
}

# Create a dev server with dock image
resource "digitalocean_droplet" "dock" {
    name = "dock"
    size = "1gb"
    image = "ubuntu-16-04-x64"
    region = "fra1"
    ipv6 = true
    private_networking = true
    ssh_keys = ["${digitalocean_ssh_key.dock.id}"]
    user_data = "${data.template_file.user_data.rendered}"
}

resource "digitalocean_floating_ip" "dock" {
    droplet_id = "${digitalocean_droplet.dock.id}"
    region = "${digitalocean_droplet.dock.region}"
}
