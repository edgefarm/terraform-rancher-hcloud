output "rancher_url" {
  description = "url via which rancher can be accessed."
  value       = local.rancher_hosturl
}

output "rancher_admin_token" {
  description = "rancher admin token to modify rancher."
  value       = rancher2_bootstrap.setup_admin.token
}

output "hetzner_driver_id" {
  description = "hetzner node driver id."
  value       = rancher2_node_driver.hetzner_node_driver.id
}
