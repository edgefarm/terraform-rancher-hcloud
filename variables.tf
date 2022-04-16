variable "cert_manager_version" {
  type        = string
  description = "cert-manager version."
  default     = "1.5.3"
}

variable "rancher_version" {
  type        = string
  description = "rancher version."
  default     = "latest"
}

variable "letsencrypt_issuer" {
  type = string
}

variable "rancher_hostname" {
  type        = string
  description = "Rancher hostname, defaults to 'https://rancher.YOUR_LB_ADDRESS.nip.io"
}

variable "rancher_admin_password" {
  type        = string
  description = "Rancher password to set for admin user."
  sensitive   = true
}

variable "lb_address" {
  type        = string
  description = "Hetzner loadbalancer address."
}

variable "kubernetes_api_server_url" {
  type        = string
  description = "Kubernetes cluster api server url where rancher will be installed."
}

variable "kubernetes_client_cert" {
  type        = string
  description = "Kubernets cluster client certificate."
  sensitive   = true
}

variable "kubernetes_client_key" {
  type        = string
  description = "Kubernets cluster client key."
  sensitive   = true
}

variable "kubernetes_ca_crt" {
  type        = string
  description = "Kubernets cluster ca certificate."
  sensitive   = true
}
