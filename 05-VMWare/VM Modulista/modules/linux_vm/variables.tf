## Lokaalit defaultit virtuaali koneelle
locals {
  vm_defaults = {
    name = null
    ip = null
    ip_gw = null
    cpu_count = 2
    memory = 4096

    dns = [
      "192.168.80.8",
      "192.168.80.9"
    ]

    linux_template_name = "Ubuntu_20.04_Template"
  }

  virtual_machine = merge(local.vm_defaults, var.virtual_machine)
}

variable "virtual_machine" {
  description = "VM määritykset"
  type = any
  default = {}
}
