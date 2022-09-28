locals {
  vsphere_datacenter      = "Datacenter"
  vsphere_compute_cluster = "cluster"
  vsphere_datastore    = "vsanDatastore"
  vsphere_network      = "vm-network01"
  vsphere_resource_pool   = "Workload"
}

data "vsphere_datacenter" "dc" {
  # name = var.vsphere_datacenter
}

data "vsphere_datastore" "datastore" {
  name          = local.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = local.vsphere_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "resource_pool" {
  name          = local.vsphere_resource_pool
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "lnx_template_vm" {
  name          = local.virtual_machine.linux_template_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm01" {
  name             = local.virtual_machine.name
  resource_pool_id = data.vsphere_resource_pool.resource_pool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = local.virtual_machine.cpu_count
  memory   = local.virtual_machine.memory
  guest_id = data.vsphere_virtual_machine.lnx_template_vm.guest_id
  firmware = data.vsphere_virtual_machine.lnx_template_vm.firmware

  scsi_type = data.vsphere_virtual_machine.lnx_template_vm.scsi_type

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.lnx_template_vm.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.lnx_template_vm.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.lnx_template_vm.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.lnx_template_vm.disks.0.thin_provisioned
  }


  clone {
    template_uuid = data.vsphere_virtual_machine.lnx_template_vm.id

    customize {
      linux_options {
        host_name = local.virtual_machine.name
        domain    = "example.com"
      }
      network_interface {
        ipv4_address = split("/", local.virtual_machine.ip)[0]
        ipv4_netmask = split("/", local.virtual_machine.ip)[1]


      }
      
      dns_server_list = local.virtual_machine.dns
      ipv4_gateway = local.virtual_machine.ip_gw

    }

  }
}
 