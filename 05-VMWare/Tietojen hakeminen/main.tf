data "vsphere_datacenter" "dc" {
    # name = var.vsphere_datacenter
}

data "vsphere_datastore" "datastore" {
    name = var.vsphere_datastore
    datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vsphere_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "resource_pool" {
    name    = var.vsphere_resource_pool
    datacenter_id   = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "win_template_vm" {
    name    = var.win_template_name
    datacenter_id   = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "lnx_template_vm" {
    name    = var.linux_template_name
    datacenter_id   = data.vsphere_datacenter.dc.id
}

## VM Resource

 