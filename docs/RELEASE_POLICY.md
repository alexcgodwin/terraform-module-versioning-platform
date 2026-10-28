# Module release engineering policy

## Public contracts and compatibility

This reference publishes three **directory examples**, not three published Git releases. Do not claim `v1.0.0`, `v1.1.0` or `v2.0.0` tags exist until you publish signed, reviewed tags.

- v1.0.0: `service_name`, `environment` required; `service_id` and `deployment_metadata` outputs.
- v1.1.0: retains all v1 inputs and outputs; adds optional `owner` and an `owner` output. It is backwards compatible in *input syntax*, though added metadata may update a `terraform_data` instance when applied. Always inspect the plan before upgrading.
- v2.0.0: replaces `service_name` with `workload_id` and `service_id` with `workload_ref`; requires `owner`. It is intentionally breaking and needs a migration guide.

## Production reference pinning

Within this repository, consumers reference folders for offline testing. A consuming repository should instead pin a **specific immutable Git tag or commit**:

```hcl
module "service" {
  source       = "git::https://github.com/alexcgodwin/terraform-module-versioning-platform.git//modules/v1_1?ref=v1.1.0"
  service_name = "checkout-api"
  environment  = "dev"
}
```

Only use this URL after publishing the matching `v1.1.0` tag. Do not rely on mutable `main` for production. Approve releases after API contract diff, validation and migration testing, and note any state address moves or potential replacements.

## Change-control gates

1. Proposed change has issue and interface impact statement.
2. Contract test compares old/new inputs and outputs.
3. Consumer smoke tests run on old and new implementations.
4. Rollback is a pinned commit and reviewed state impact.
5. CHANGELOG documents major/minor/patch and upgrade steps.
6. CI build success is not proof of safe production upgrade; review the actual provider plan.
