run "contract_v2" {
  command = plan
  assert {
    condition     = output.workload_ref == "dev/checkout-api"
    error_message = "v2 contract changed unexpectedly"
  }
}
