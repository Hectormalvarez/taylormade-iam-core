variable "iso_local_path" {
  type        = string
  default     = "/home/hadev/Downloads/windows_server_2022.iso"
  description = "The path to the Windows Server 2022 ISO on your laptop"
}

variable "disk_size_gb" {
  type        = string
  default     = "40G"
  description = "The size of the primary OS virtual hard drive during image compilation"
}

variable "winrm_username" {
  type        = string
  default     = "Administrator"
  description = "The default local admin account name configured by the answer file"
}

variable "winrm_password" {
  type        = string
  default     = "TaylormadeAD2026!"
  description = "The password injected into the local administrator account"
}