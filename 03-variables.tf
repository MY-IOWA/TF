variable "environment" {
  type        = string
  description = "Deployment Environment (e.g., dev, staging, prod)"
  default     = "dev"
}
variable "business_unit" {
  type        = string
  description = "Business Unit (e.g., finance, hr, it)"
  default     = "hr"
}
/*
variable "linux_vm_size" {
  type        = string
  description = "Size of the Virtual Machine"
  default     = "Standard_B2ats_v2"
}

variable "location" {
  type        = string
  description = "Azure Region"
}

variable "resource_group_name" {
  type = string
  description = "Resource Group Name"
}
variable "resource_group_location" {
  type = string
  description = "Location of the Resource Group"
}
variable "vm_name" {
  type = string
  description = "Virtual Machine Name"
}
variable "admin_username" {
  type = string
  description = "Admin Username for the Virtual Machine"
}
variable "admin_password" {
  type = string
  description = "Admin Password for the Virtual Machine"
  sensitive = true
}
variable "windows_vm_size" {
  type = string
  description = "Size of the Virtual Machine"
}

variable "windows_image_publisher" {
  type = string
  description = "Publisher of the Windows VM Image"
}
variable "linux_image_publisher" {
  type = string
  description = "Publisher of the Linux VM Image"
}
variable "windows_image_offer" {
  type = string
  description = "Offer of the Windows VM Image"
}
variable "linux_image_offer" {
  type = string
  description = "Offer of the Linux VM Image"
}
variable "windows_image_sku" {
  type = string
  description = "SKU of the Windows VM Image"
}
variable "linux_image_sku" {
  type = string
  description = "SKU of the VM Image"
}
variable "windows_image_version" {
  type = string
  description = "Version of the Windows VM Image"
}
variable "linux_image_version" {
  type = string
  description = "Version of the Linux VM Image"
}
variable "admin_ssh_public_key" {
  type = string
  description = "Admin SSH Public Key for the Linux Virtual Machine"
}
variable "admin_ssh_private_key" {
  type = string
  description = "Admin SSH Private Key for the Linux Virtual Machine"
  sensitive = true
}
variable "os_disk_size_gb" {
  type = number
  description = "Size of the OS Disk in GB"
}
variable "virtual_network_name" {
  type = string
  description = "Name of the Virtual Network"
}
variable "subnet_name" {
  type = string
  description = "Name of the Subnet"
}
variable "network_security_group_name" {
  type = string
  description = "Name of the Network Security Group"
}
variable "public_ip_name" {
  type = string
  description = "Name of the Public IP Address"
}
variable "network_interface_name" {
  type = string
  description = "Name of the Network Interface"
}
variable "windows_computer_name" {
  type = string
  description = "Computer Name for the Windows Virtual Machine"
}
variable "linux_computer_name" {
  type = string
  description = "Computer Name for the Linux Virtual Machine"
}
variable "os_type" {
  type = string
  description = "Operating System Type (Windows or Linux)"
}
*/