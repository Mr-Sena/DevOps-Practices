terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~>2.0.0"
    }
  }
}


resource "digitalocean_vpc" "wp_net" {
  name     = var.wp_net_name
  region   = var.region

  timeouts {
    delete = "30m"
  }
}

resource "digitalocean_loadbalancer" "wp_lb" {
  name   = var.wp_lb
  region = var.region

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 80
    target_protocol = "http"
  }

  healthcheck {
    port     = 80
    protocol = "http"
    path = "/"
  }

  vpc_uuid = digitalocean_vpc.wp_net.id

  droplet_ids = [digitalocean_droplet.vm_wp_01.id, digitalocean_droplet.vm_wp_02.id]
}

resource "digitalocean_droplet" "vm_wp_01" {
  name     = var.vm_wp_01_name
  size     = "s-2vcpu-2gb"
  image    = "ubuntu-22-04-x64"
  region   = var.region
  vpc_uuid = digitalocean_vpc.wp_net.id
}

resource "digitalocean_droplet" "vm_wp_02" {
  name     = var.vm_wp_01_name
  size     = "s-2vcpu-2gb"
  image    = "ubuntu-22-04-x64"
  region   = var.region
  vpc_uuid = digitalocean_vpc.wp_net.id
}

resource "digitalocean_droplet" "vm_nfs" {
  name     = var.vm_nfs_name
  size     = "s-2vcpu-2gb"
  image    = "ubuntu-22-04-x64"
  region   = var.region
  vpc_uuid = digitalocean_vpc.wp_net.id
}

resource "digitalocean_database_db" "wp_database" {
  cluster_id = digitalocean_database_cluster.wp_mysql.id
  name       = var.wp_database_name
}

resource "digitalocean_database_cluster" "wp_mysql" {
  name                 = var.wp_mysql_cluster_name
  engine               = "mysql"
  version              = "8"
  size                 = "db-s-1vcpu-1gb"
  region               = var.region
  node_count           = 1
  private_network_uuid = digitalocean_vpc.wp_net.id
}

resource "digitalocean_database_user" "wp_database_user" {
  cluster_id = digitalocean_database_cluster.wp_mysql.id
  name       = var.wp_database_user_name
}
