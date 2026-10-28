terraform { required_version = ">= 1.6.0" }
variable "service_name" {
  type        = string
  description = "v1-compatible input remains mandatory."
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
variable "owner" {
  type        = string
  default     = "platform"
  description = "New optional v1.1 parameter; no v1 consumer breaks."
  validation {
    condition     = length(trimspace(var.owner)) >= 3
    error_message = "owner requires at least three characters."
  }
}
resource "terraform_data" "service_contract" {
  input = {
    name        = var.service_name
    environment = var.environment
    owner       = var.owner
  }
}
output "service_id" { value = "${var.environment}/${var.service_name}" }
output "deployment_metadata" { value = terraform_data.service_contract.output }
output "owner" { value = var.owner }
