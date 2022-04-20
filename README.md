# terraform-rancher-hcloud

terraform module to setup rancher(ha) on hetzner hcloud.

This project is highly inspired by [alexzimmer96/rancher-hcloud](https://github.com/alexzimmer96/rancher-hcloud),
but separates the setup of the rke cluster from the helm based rancher setup, because of flexibility and k8s best practices.

The rke-hcloud terraform module can be found [here](https://github.com/edgefarm/terraform-rke-hcloud).

## example

Go to example folder, adjust main.tf and run:

```bash
terraform init
terraform apply
```

After the commands have been executed (takes a view minutes),

Test your cluster:

```bash
terraform output rancher_url
```

Open url in your webbrowser and login with user `admin` and your admin password.
