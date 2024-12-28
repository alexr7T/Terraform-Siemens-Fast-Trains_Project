# 🚆 **Siemens Fast Trains Terraform Project**

## 📑 **Table of Contents**
- [📌 Pre-requisites](#pre-requisites)
- [⚙️ Chosen Resources](#chosen-resources)
- [🛠️ Concrete Plan](#concrete-plan)
- [🔧 Technical Considerations](#technical-considerations)
- [📈 Business Approach](#business-approach)

---

## 📌 **Pre-requisites**
To deploy the Siemens Fast Trains infrastructure using Terraform, the following pre-requisites must be met:

1. **Azure Subscription:** Ensure access to an Azure subscription with sufficient permissions to create and manage resources.

2. **Terraform Installed:** Install Terraform version `>= 1.0.0`. Refer to [Terraform Installation Guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).

3. **Azure CLI:** Install Azure CLI for authentication and management of Azure resources. Refer to [Azure CLI Installation Guide](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli).

4. **Azure Key Vault Configuration:**
   - A Key Vault must be provisioned prior to executing the Terraform scripts.
   - Ensure the following secrets are created in the Key Vault:
     - `VmAdminPassword`: Stores the administrator password for the Virtual Machine.
     - `SqlAdminPassword`: Stores the administrator password for the SQL Server.
   - Assign proper access policies to the Service Principal or Managed Identity used by Terraform. Ensure permissions for `get` and `list` operations are granted.

5. **Azure Service Principal:** A Service Principal with contributor access to the target resource group is required.

---

## ⚙️ **Chosen Resources**
The following Azure resources are defined and deployed in this project:

- **Resource Group:** Centralized resource container for all project components.
- **Virtual Network (VNet):** Configured with a public subnet to enable secure communication between resources.
- **Network Security Group (NSG):** Ensures controlled inbound and outbound traffic with the following rules:
  - HTTP inbound traffic.
  - HTTPS outbound traffic.
  - RDP inbound traffic for administrative purposes.
- **Public IP:** Dynamic allocation for external connectivity.
- **Windows Virtual Machine:** Configured with an attached data disk and a secure administrator account retrieved from Key Vault.
- **Azure Key Vault:** Manages sensitive information such as VM and SQL passwords.
- **SQL Server and Database:** Provisioned for application data with encrypted connections enforced.
- **Managed Disk:** Additional data storage attached to the VM.

---

## 🛠️ **Concrete Plan**
The project is structured to follow a step-by-step deployment plan:

1. **Authentication and Initialization:**
   - Authenticate with Azure using Azure CLI (`az login`).
   - Initialize Terraform with `terraform init`.

2. **Validate Configuration:**
   - Run `terraform validate` to ensure the configuration files are syntactically correct.

3. **Execution:**
   - Execute `terraform plan` to preview resource changes.
   - Deploy resources using `terraform apply`.

4. **Key Vault Secret Management:**
   - Ensure the secrets (`VmAdminPassword`, `SqlAdminPassword`) are created in Key Vault before deployment.
   - Terraform will retrieve these secrets dynamically during execution.

5. **Post-Deployment:**
   - Verify resources in the Azure portal.
   - Test connectivity and application functionality as per business requirements.

---

## 🔧 **Technical Considerations**
1. **Key Vault Integration:**
   - Sensitive data is managed via Azure Key Vault. Secrets are dynamically referenced using `data.azurerm_key_vault_secret` resources to avoid hardcoding sensitive values.

2. **Resource Naming Conventions:**
   - Names are aligned with organizational policies and restricted to Azure’s character limitations.

3. **Security:**
   - Network Security Group (NSG) rules are defined to minimize exposure while allowing essential traffic.
   - Minimum TLS version (`1.2`) is enforced on the SQL Server.

4. **Scalability:**
   - Resources are configured with flexibility for future scaling.
   - Modular configuration ensures ease of updates.

5. **Resilience:**
   - Lifecycle rules such as `prevent_destroy` are applied to critical resources like the database to prevent accidental deletion.

---

## 📈 **Business Approach**
1. **Cost Efficiency:**
   - Leveraged cost-effective Azure resources, e.g., `Standard_B1s` VM size and `Basic` SQL SKU for economic optimization.
   - Public IP allocation is dynamic, minimizing static IP costs.

2. **Security First:**
   - Passwords and sensitive data are managed securely through Azure Key Vault, reducing operational risks.
   - Network traffic is controlled using fine-grained NSG rules.

3. **Simplicity and Automation:**
   - Automating infrastructure deployment via Terraform minimizes manual effort and accelerates project timelines.
   - Modular design promotes reusability and simplifies management.

4. **Compliance:**
   - Resources adhere to organizational policies for security and naming conventions.
   - Ensures compliance with Azure's best practices.

5. **Future Growth:**
   - Infrastructure is designed for scalability, enabling seamless expansion as project demands grow.

---

For detailed explanations and troubleshooting, please refer to the Azure and Terraform documentation or contact the infrastructure team.
