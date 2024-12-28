#### General Parameters ####

variable "rg" {
  description = "Resource Group Name"
  type        = string
  default     = "siemens-proj-rg"
  validation {
    condition     = length(var.rg) > 2 && length(var.rg) <= 64
    error_message = "Resource Group Name must be between 3 and 64 characters."
  }
}

variable "location" {
  description = "Azure Region for resources"
  default     = "Germany West Central"
}

variable "allocation" {
  default = "Dynamic"
}

variable "direction_in" {
  default = "inbound"
}

variable "direction_out" {
  default = "outbound"
}

variable "traffic_allowed" {
  default = "Allow"
}

variable "traffic_denied" {
  default = "Denied"
}

variable "traffic_protocol" {
  description = "Default protocol for network traffic"
  type        = string
  default     = "Tcp"
}

variable "allow_all" {
  description = "Wildcard for allowing all traffic"
  default     = "*"
}

#### VM Parameters ####

variable "vm_name" {
  description = "Name of the virtual machine"
  default     = "siemens-vm"
  validation {
    condition     = length(var.vm_name) > 2 && length(var.vm_name) <= 15
    error_message = "VM name must be between 3 and 15 characters."
  }
}

variable "vm_computer_name" {
  default = "advcvm01"
}

variable "vm_size" {
  description = "Azure VM size"
  default     = "Standard_B1s"
}

variable "vm_user" {
  description = "Admin username for the VM"
  default     = "adminuser"
  validation {
    condition     = length(var.vm_user) >= 3 && length(var.vm_user) <= 20
    error_message = "Admin username must be between 3 and 20 characters."
  }
}

variable "vm_pass" {
  description = "Admin password for the VM (retrieved from Key Vault)"
  type        = string
  sensitive   = true
}

variable "image_publisher" {
  default = "MicrosoftWindowsServer"
}

variable "image_offer" {
  default = "WindowsServer"
}

variable "image_sku" {
  default = "2019-Datacenter"
}

variable "image_version" {
  default = "latest"
}

#### Disk Parameters ####

variable "caching" {
  default = "ReadWrite"
}

variable "storage_account_type" {
  default = "Standard_LRS"
}

variable "data_disk_name" {
  default = "terraform-vm-data-disk"
}

variable "create_option" {
  default = "Empty"
}

variable "disk_size" {
  description = "Size of the managed disk in GB"
  type        = number
  default     = 10
  validation {
    condition     = var.disk_size >= 4 && var.disk_size <= 1024
    error_message = "Disk size must be between 4 and 1024 GB."
  }
}

variable "logical_number" {
  default = "10"
}

#### VNet / Subnet Parameters ####

variable "vnet_name" {
  default = "siemens-vnet"
}

variable "vnet_range" {
  description = "Address range for the virtual network"
  type        = list(string)
  default     = ["10.5.0.0/16"]
  validation {
    condition     = length(var.vnet_range) > 0
    error_message = "VNet range must include at least one CIDR block."
  }
}

variable "public_subnet_name" {
  default = "public-resources"
}

variable "public_subnet_range" {
  description = "Address range for the public subnet"
  type        = list(string)
  default     = ["10.5.0.0/24"]
}

#### NIC Parameters ####

variable "nic_name" {
  default = "advc-windows-vm-nic"
}

variable "ip_config_name" {
  default = "internal"
}

variable "private_ip_allocation" {
  default = "Dynamic"
}

#### PIP Parameters ####

variable "public_ip_name" {
  default = "public-ip"
}

#### NSG Parameters ####

variable "nsg_name" {
  default = "siemens-nsg"
}

#### NSG Rules Parameters ####

variable "https_out_rule_name" {
  default = "https-outbound"
}

variable "https_priority" {
  description = "Priority for HTTPS rule in NSG"
  type        = number
  default     = 110
  validation {
    condition     = var.https_priority >= 100 && var.https_priority <= 4096
    error_message = "Priority must be between 100 and 4096."
  }
}

variable "https_port" {
  default = 443
}

variable "http_rule_name" {
  default = "http_inbound"
}

variable "http_priority" {
  default = 120
}

variable "http_port" {
  default = 80
}

variable "rdp_rule_name" {
  default = "rdp-inbound"
}

variable "rdp_priority" {
  description = "Priority for RDP rule in NSG"
  type        = number
  default     = 130
}

variable "rdp_port" {
  default = 3389
}

#### SQL Server Parameters ####

variable "sql_server_name" {
  description = "Name of the SQL Server"
  default     = "dom-sql-server"
  validation {
    condition     = length(var.sql_server_name) > 2 && length(var.sql_server_name) <= 63
    error_message = "SQL Server name must be between 3 and 63 characters."
  }
}

variable "sql_server_version" {
  default = "12.0"
}

variable "sql_administrator_login_name" {
  description = "Administrator login name for SQL Server"
  default     = "missadministrator"
}

variable "sql_administrator_login_password" {
  description = "Administrator password for SQL Server (retrieved from Key Vault)"
  type        = string
  sensitive   = true
}

variable "sql_tls_version" {
  default = "1.2"
}

#### SQL Database Parameters ####

variable "sql_database_name" {
  description = "Name of the SQL Database"
  default     = "sql-acctest-db-b"
  validation {
    condition     = length(var.sql_database_name) > 2 && length(var.sql_database_name) <= 128
    error_message = "SQL Database name must be between 3 and 128 characters."
  }
}

variable "sql_database_collation" {
  default = "SQL_Latin1_General_CP1_CI_AS"
}

variable "sql_database_sku" {
  default = "Basic"
}

variable "max_size_gb" {
  default = 1
}