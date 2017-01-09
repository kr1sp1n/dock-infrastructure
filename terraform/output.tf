output "floating_ip" {
  value = "${digitalocean_floating_ip.dock.ip_address}"
}
