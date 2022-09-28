# Muuttujat vSphere ympäristöä varten
variable "vsphere_user" {
    type = string
}

variable "vsphere_password" {
    type = string
}

variable "vsphere_server" {
    type = string
}

variable "vsphere_datacenter" {
    type = string
}

variable "vsphere_datastore" {
  description = "Datastore to deploy the VM."
  default     = ""
  type = string
}

variable "vsphere_network" {
    type    = string
}

variable "vsphere_resource_pool" {
    type = string
}

# Muuttujia VM luontia varten
variable "win_template_name" {
    type    = string
    default = ""
}

variable "linux_template_name" {
    type    = string
    default = ""
}

# variable "virtual_machine_name" {
#     type    = string
# }

# variable "admin_password" {
#     type    = string
#     default = ""
# }

# variable "vm_dns" {
#     type = list(string)
#     default = null
# }