terraform { required_version = ">= 1.6.0" }
module "service" {
  source       = "../../modules/v1_1"
  service_name = "checkout-api"
  environment  = "dev"
  # Existing v1 input list still works; owner defaults safely.
}
output "service_id" { value = module.service.service_id }
output "owner" { value = module.service.owner }
