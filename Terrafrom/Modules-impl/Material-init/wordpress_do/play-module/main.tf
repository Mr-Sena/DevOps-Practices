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


module "wordpress-module" {
  source = "./wordpress-infra-module"
  region = var.region
}


module "wordpress-backup-module" {
  source                = "./wordpress-infra-module"
  region                = "nyc3"
  vm_nfs_name           = "nfs-backup"
  vm_wp_01_name         = "backup-machine-01"
  vm_wp_02_name         = "backup-machine-02"
  wp_net_name           = "network-live"
  wp_database_name      = "backup-database"
  wp_mysql_cluster_name = "backup-cluster"
  wp_database_user_name = "backup-user"
  wp_lb = "backup-loadbalancer"
}