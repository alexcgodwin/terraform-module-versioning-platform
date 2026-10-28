terraform { required_version = ">= 1.6.0" }
variable "workload_id" {
  type        = string
  description = "BREAKING CHANGE: replaces service_name."
  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{2,30}$", var.workload_id))
    error_message = "workload_id must be 3-31 lowercase DNS-style characters."
  }
}
variable "environment" {
  type = string
  validation {
    condition     = contains(["dev", "stage", "prod"], var.environment)
    error_message = "Use dev, stage or prod."
  }
}
variable "owner" { type = string }
resource "terraform_data" "workload_contract" {
  input = {
    workload_id = var.workload_id
    environment = var.environment
    owner       = var.owner
  }
}
output "workload_ref" { value = "${var.environment}/${var.workload_id}" }
output "deployment_metadata" { value = terraform_data.workload_contract.output }
