variable "region" {
  type    = string
  default = "nyc1"
}

variable "wp_net_name" {
  type    = string
  default = "wp-netowrk"
}

variable "wp_lb" {
  type    = string
  default = "wp-lb"
}

variable "vm_wp_01_name" {
  type    = string
  default = "vm-wp-01"
}


variable "vm_wp_02_name" {
  type    = string
  default = "vm-wp-02"
}

variable "vm_nfs_name" {
  type    = string
  default = "vm-nfs"
}


variable "wp_database_name" {
  type    = string
  default = "wp-database"
}

variable "wp_mysql_cluster_name" {
  type    = string
  default = "wp-mysql"
}

variable "wp_database_user_name" {
  type    = string
  default = "wordpress"
}

