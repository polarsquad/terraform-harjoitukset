terraform {
  required_version = "~>1.3.0"
  required_providers {
    vsphere = {
      version = "~>2.2.0"
      source  = "hashicorp/vsphere"
    }
  }
}
