module "linux_test" {
  source = "../modules/linux_vm"
  
  virtual_machine = {
    name  = "lnx-module-test"
    ip = "10.88.10.111/24"
    ip_gw = "10.88.10.1"
    # cpu_count = 4
  }
}

output "vm_guest_os" {
    value = module.linux_test.guest_ip_addresses
}
