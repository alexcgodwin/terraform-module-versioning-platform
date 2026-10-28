terraform { required_version = ">= 1.6.0" }
module "service" {
  source       = "../../modules/v1"
  service_name = "checkout-api"
  environment  = "dev"
}
output "service_id" { value = module.service.service_id }
