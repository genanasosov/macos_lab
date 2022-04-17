packer {
  required_plugins {
    vmware = {
      version = ">= 1.0.3"
      source = "github.com/hashicorp/vmware"
    }
  }
}

source "vmware-iso" "basic-example" {
  iso_url = "/Users/antonrazvodov/Desktop/lab/fedora35arm.iso"
  iso_checksum = "f80d64cf79f83b978e4e188c54d5546d3e118e6c"
  ssh_username = "vagrant"
  ssh_password = "vagrant"
  headless             = "false"
  vnc_bind_address     = "127.0.0.1"
  vnc_disable_password = "false"
  vnc_port_min         = "5900"
  vnc_port_max         = "6000"
  shutdown_command = "echo 'packer' | sudo -S -E shutdown -P now"
  boot_command         = ["e<down><down><end><bs><bs><bs><bs><bs>inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<leftCtrlOn>x<leftCtrlOff>"]
  boot_wait            = "5s"
  cpus                 = "2"
  cores                = "2"
  disk_size            = "20000"
  http_directory       = "./"
  memory               = "4096"
  ssh_timeout          = "10m"
  vm_name              = "fedora35arm"
  cdrom_adapter_type   = "sata"
  disk_adapter_type    = "nvme"
  network_adapter_type = "e1000"
  disk_type_id         = "0"
  usb                  = "true"
  version              = "19"
  display_name         = "fedora35arm"
  vmdk_name            = "fedora35arm"
  network              = "nat"
  guest_os_type        = "arm-fedora-64"
}

build {
  sources = ["sources.vmware-iso.basic-example"]

  post-processor "vagrant" {
    compression_level = 0
  }
}