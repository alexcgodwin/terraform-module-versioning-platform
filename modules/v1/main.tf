terraform { required_version = ">= 1.6.0" }
variable "service_name" {
  type        = string
  description = "Existing v1 consumer input; preserved in v1.1."
  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{2,30}$", var.service_name))
    error_message = "Service name must use 3-31 lowercase DNS-style characters."
  }
}
variable "environment" {
  type = string
  validation {
    condition     = contains(["dev", "stage", "prod"], var.environment)
    error_message = "Use dev, stage or prod."
  }
}
resource "terraform_data" "service_contract" {
  input = {
    name        = var.service_name
    environment = var.environment
  }
}
output "service_id" { value = "${var.environment}/${var.service_name}" }
output "deployment_metadata" { value = terraform_data.service_contract.output }
