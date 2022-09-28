terraform {
    required_version = "~>1.3.0"
    required_providers {
        vsphere = {
            version = "~>2.2.0"
            source = "hashicorp/vsphere"
        }
    }
}

provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server
  
  allow_unverified_ssl = true
}