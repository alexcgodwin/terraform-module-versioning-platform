run "contract_v1_1" {
  command = plan
  assert {
    condition     = output.service_id == "dev/checkout-api"
    error_message = "v1.1 contract changed unexpectedly"
  }
}
