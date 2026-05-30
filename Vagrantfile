# -*- mode: ruby -*-
# vim: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "taylormade-2022-core"

  # Explicitly tell Vagrant the guest target is Windows
  config.vm.guest = :windows

  config.vm.define "iam-base" do |node|
    node.vm.hostname = "win22-core-base"

    # Disable the default Linux rsync synced folder completely
    node.vm.synced_folder ".", "/vagrant", disabled: true

    # Forward WinRM ports for management connectivity
    node.vm.network "forwarded_port", guest: 5985, host: 5985, id: "winrm", auto_correct: true
    node.vm.network "forwarded_port", guest: 5986, host: 5986, id: "winrm-ssl", auto_correct: true

    # Configure Communicator Settings for Windows
    node.vm.communicator = "winrm"
    node.winrm.username = "Administrator"
    node.winrm.password = "TaylormadeAD2026!"
    
    # Provider-specific configurations for QEMU/KVM (libvirt)
    node.vm.provider :libvirt do |lv|
      lv.memory = 4096
      lv.cpus   = 2
      
      # Force stable emulation parameters 
      lv.disk_bus       = "ide"
      lv.nic_model_type = "e1000"
    end
  end
end