output "datacenter" {
    value = data.vsphere_datacenter.dc.id
}

output "datastore" {
    value = data.vsphere_datastore.datastore.id
}

output "network" {
    value = data.vsphere_network.network.id
}

output "resource_pool" {
    value = data.vsphere_resource_pool.resource_pool.id
}

output "windows_template_vm_id" {
    value = data.vsphere_virtual_machine.win_template_vm.id
}

output "linux_template_vm_id" {
    value = data.vsphere_virtual_machine.lnx_template_vm.id
}

output "vm_network_id" {
    value = data.vsphere_network.network.id
}