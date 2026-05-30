# taylormade-iam-core

An automated, high-performance Identity and Access Management (IAM) sandbox laboratory. This repository leverages HashiCorp Packer to build a pristine, standardized Windows Server 2022 Core base image via QEMU/KVM, and utilizes Vagrant (with the `vagrant-libvirt` provider) for headless multi-VM infrastructure orchestration.

---

## 🛠️ Host Prerequisites

Before spinning up the environment, your Linux host must have the KVM hypervisor stack, QEMU utilities, and Vagrant development headers installed.

### 1. Install System Dependencies

```bash
sudo apt update
sudo apt install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager libvirt-dev ruby-dev build-essential -y

```

### 2. Configure User Permissions

To allow Vagrant and Virt-Manager to interact directly with the KVM hypervisor socket without requiring `sudo`:

```bash
sudo usermod -aG libvirt $USER
sudo usermod -aG kvm $USER

```

*Note: You must log out of your system desktop session and log back in (or reboot) for these group permissions to fully take effect.*

### 3. Install Vagrant Plugins

Install the `vagrant-libvirt` provider extension:

```bash
vagrant plugin install vagrant-libvirt

```

---

## 🏭 Phase 1: The Image Factory (Packer)

The `packer/` directory contains the automation code to install Windows Server 2022 Core headlessly using an unattend answer file.

1. Navigate to the packer directory:
```bash
cd packer

```


2. Build the base image. Packer will compile the OS inside a temporary directory, package it into a compressed Vagrant `.box` file, and automatically purge the massive raw disk artifact upon completion:
```bash
packer build .

```


3. Register the newly generated box file into your local Vagrant inventory:
```bash
vagrant box add taylormade-2022-core ./build-artifacts/windows-2022-core-libvirt.box

```



---

## 🚀 Phase 2: Lab Orchestration (Vagrant)

Once the base box is registered, the image factory is closed. All virtual machine management and lab infrastructure deployment are executed from the root of the repository.

### Spin Up the Environment

From the root project directory (`taylormade-iam-core/`), fire up the headless Windows instance:

```bash
vagrant up --provider=libvirt

```

### Accessing the Machine

Because the image is pre-configured with WinRM authentication, you can drop directly into a remote administrative PowerShell terminal on the guest system without a GUI console:

```bash
vagrant powershell

```

### Core Management Commands

* **Pause the lab** (saves VM state to disk): `vagrant suspend`
* **Resume the lab**: `vagrant up`
* **Wipe the lab** (completely destroys the instances, leaving a clean slate): `vagrant destroy -force`
