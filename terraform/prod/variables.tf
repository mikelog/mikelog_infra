variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable disk_image {
  description = "Disk image"
}

variable private_key_path {
  description = "Path to private key used for provisioners"
}

variable app_region {
  description = "App Region"
  default     = "europe-west1-b"
}

variable zone {
  description = "Region"
  default     = "europe-west1-b"
}

variable inst_cnt {
  description = "Count of instances"
  default     = "1"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}
