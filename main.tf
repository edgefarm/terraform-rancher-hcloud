terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.5.1"
    }
    rancher2 = {
      source  = "rancher/rancher2"
      version = "1.23.0"
    }
  }
}

provider "helm" {
  kubernetes {
    host                   = var.kubernetes_api_server_url
    client_certificate     = var.kubernetes_client_cert
    client_key             = var.kubernetes_client_key
    cluster_ca_certificate = var.kubernetes_ca_crt
  }
}

provider "rancher2" {
  alias     = "bootstrap"
  api_url   = local.rancher_hosturl
  bootstrap = true
  insecure  = true
}

provider "rancher2" {
  alias     = "admin"
  api_url   = local.rancher_hosturl
  token_key = rancher2_bootstrap.setup_admin.token
  insecure  = true
}

locals {
  rancher_hosturl  = var.rancher_hostname != null ? "https://${var.rancher_hostname}" : "https://rancher.${var.lb_address}.nip.io"
  rancher_hostname = var.rancher_hostname != null ? "${var.rancher_hostname}" : "rancher.${var.lb_address}.nip.io"
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  namespace  = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = var.cert_manager_version

  wait             = true
  create_namespace = true
  force_update     = true
  replace          = true

  set {
    name  = "installCRDs"
    value = true
  }
}

resource "helm_release" "rancher" {
  name       = "rancher"
  namespace  = "cattle-system"
  chart      = "rancher"
  repository = "https://releases.rancher.com/server-charts/stable"
  version    = var.rancher_version
  depends_on = [helm_release.cert_manager]

  wait             = true
  create_namespace = true
  force_update     = true
  replace          = true

  set {
    name  = "hostname"
    value = local.rancher_hostname
  }

  set {
    name  = "ingress.tls.source"
    value = "letsEncrypt"
  }

  set {
    name  = "letsEncrypt.email"
    value = var.letsencrypt_issuer
  }

  set {
    name  = "bootstrapPassword"
    value = var.rancher_admin_password
  }
}

resource "rancher2_bootstrap" "setup_admin" {
  provider         = rancher2.bootstrap
  password         = var.rancher_admin_password
  initial_password = var.rancher_admin_password
  telemetry        = true
  depends_on       = [helm_release.rancher]
}

resource "rancher2_node_driver" "hetzner_node_driver" {
  provider          = rancher2.admin
  active            = true
  builtin           = false
  name              = "hetzner"
  ui_url            = "https://storage.googleapis.com/hcloud-rancher-v2-ui-driver/component.js"
  url               = "https://github.com/JonasProgrammer/docker-machine-driver-hetzner/releases/download/3.3.1/docker-machine-driver-hetzner_3.3.1_linux_amd64.tar.gz"
  whitelist_domains = ["storage.googleapis.com"]
}
