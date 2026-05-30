packer {
  required_plugins {
    qemu = {
      version = ">= 1.1.4"
      source  = "github.com/hashicorp/qemu"
    }
  }
}

source "qemu" "windows_core" {
  iso_url          = var.iso_local_path
  iso_checksum     = "none"
  output_directory = "../build-windows-core"
  
  cpus             = 2
  memory           = 4096
  disk_size        = var.disk_size_gb
  disk_interface   = "ide"
  net_device       = "e1000"
  accelerator      = "kvm"

  floppy_files = [
    "./answer-files/Autounattend.xml",
    "./scripts/bootstrap-winrm.ps1"
  ]

  boot_wait    = "2s"
  boot_command = ["<enter>"]

  communicator   = "winrm"
  winrm_username = var.winrm_username
  winrm_password = var.winrm_password
  winrm_timeout  = "1h"

  shutdown_command = "shutdown /s /t 10 /f /d p:4:1"
}

build {
  sources = ["source.qemu.windows_core"]

  provisioner "powershell" {
    inline = [
      "Write-Output 'Base Windows Server Core image build complete.'"
    ]
  }
}