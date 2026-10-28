terraform { required_version = ">= 1.6.0" }
module "workload" {
  source      = "../../modules/v2"
  workload_id = "checkout-api"
  environment = "dev"
  owner       = "payments-team"
}
output "workload_ref" { value = module.workload.workload_ref }
