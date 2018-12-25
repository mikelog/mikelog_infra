variable public_key_path {
  description = "Path to the public key used to connect to instance"
}

variable private_key_path {
  description = "Path to private key used for provisioners"
}

variable zone {
  description = "Zone"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable db_internal_ip {
  description = "Internal DB instance IP"
}

variable use_provisioner {
  description = "Enable the use of provisioner"
  default     = "true"
}
