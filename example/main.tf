module "rancher_init" {
  source                    = "../"
  letsencrypt_issuer        = "youremail@address.com"
  rancher_admin_password    = "" # INSERT YOUR SUPER SECRET PASS HERE
  rancher_hostname          = "INSERT YOUR HOSTNAME HERE"
  lb_address                = "INSERT YOUR HCLOUD LB ADDRESS HERE"
  kubernetes_api_server_url = "INSERT YOUR API SERVER URL HERE "
  kubernetes_client_cert    = "INSERT YOUR CLIENT CERT HERE"
  kubernetes_client_key     = "INSERT YOUR CLIENT KEY HERE"
  kubernetes_ca_crt         = "INSERT YOUR CA CERT HERE"
}
