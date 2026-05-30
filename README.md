# taylormade-iam-core

The foundation of my automated lab environment. `taylormade-iam-core` is the central engine for spinning up pristine, disposable Windows Server infrastructure, specifically architected for Active Directory, Identity & Access Management (IAM), and system administration engineering.

## Project Vision

This project provides a fully automated, headless "factory" to generate standardized Windows Server 2022 Core images. These images serve as the base for all downstream lab projects, allowing for rapid, reproducible deployment of complex domain environments, security testing, and policy automation.

## Core Capabilities

* **Automated Lifecycle:** From ISO to hardened, network-ready template in minutes.
* **Infrastructure as Code:** Built on Packer and QEMU/KVM for local, high-performance virtualization.
* **Standardized Foundation:** Baked-in WinRM connectivity and firewall pre-configuration, ready for immediate integration with Vagrant and Ansible.
* **Modular Lab Design:** Designed to act as the primary building block for Active Directory domains, RBAC testing, and IAM policy sandboxes.

## Architecture

* **Hypervisor:** QEMU/KVM
* **Orchestration:** Packer (Image Factory)
* **Host System:** Linux (Austin, TX Workstation)
* **OS Target:** Windows Server 2022 Core (x64)

## Project Structure

```text
.
├── answer-files/       # Automated Windows Setup (Unattended XML)
├── packer/             # Packer build configuration and variables
├── scripts/            # Post-install bootstrapping (WinRM configuration)
└── .gitignore          # Build artifact and sensitive environment exclusions

```

## Getting Started

1. **Prerequisites:** Ensure `packer` and `qemu-kvm` are installed.
2. **Setup:** Place your `windows_server_2022.iso` in `~/Downloads`.
3. **Build:** 

```bash
cd packer
packer init .
packer build .
```
