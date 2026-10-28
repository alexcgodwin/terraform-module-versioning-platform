run "contract_v1" {
  command = plan
  assert {
    condition     = output.service_id == "dev/checkout-api"
    error_message = "v1 contract changed unexpectedly"
  }
}
