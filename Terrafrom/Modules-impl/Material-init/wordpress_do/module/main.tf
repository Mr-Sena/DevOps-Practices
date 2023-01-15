terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~>2.0.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

module "wp_do" {

  source = "./digital_ocean_wordpress"
  region = var.region
  providers = {
    digitalocean = digitalocean
  }
}

resource "digitalocean_kubernetes_cluster" "k8s" {
  name     = "k8s"
  region   = var.region
  version  = "1.25.4-do.0"
  vpc_uuid = module.wp_do.vpc_uuid

  node_pool {
    name       = "default"
    size       = "s-2vcpu-2gb"
    node_count = 3
  }
}
