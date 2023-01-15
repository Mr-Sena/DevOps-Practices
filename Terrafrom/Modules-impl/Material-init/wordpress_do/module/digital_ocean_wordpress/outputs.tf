output "lb_ip" {
  value = digitalocean_loadbalancer.wp_lb.ip
}

output "vpc_uuid" {
  value = digitalocean_vpc.wp_net.id
}

output "database_username" {
  value = digitalocean_database_user.wp_database_user.name
}

output "database_password" {
  value     = digitalocean_database_user.wp_database_user.password
  sensitive = true
}
