# Terraform Module Versioning and Compatibility Platform

[![Module CI](https://github.com/alexcgodwin/terraform-module-versioning-platform/actions/workflows/ci.yml/badge.svg)](https://github.com/alexcgodwin/terraform-module-versioning-platform/actions/workflows/ci.yml)

A reproducible study of Terraform **public module contracts**, semantic versioning, backward-compatible evolution, breaking changes and staged consumer migration. Uses `terraform_data` to demonstrate realistic interface management without a cloud bill or credentials.

## Module versions

| Reference directory | API change | Compatibility |
| --- | --- | --- |
| `modules/v1` | Initial required inputs `service_name`, `environment` | Baseline |
| `modules/v1_1` | Optional `owner`, stable existing outputs | Syntax backward compatible |
| `modules/v2` | New `workload_id`, new required `owner`, renamed output | Major breaking change |

The version labels are demonstration contracts, **not published Git tags**. See [Release Policy](docs/RELEASE_POLICY.md) for an example of immutable Git refs and [V2 migration](docs/MIGRATION_V2.md) for real upgrade gates.

## Offline CI verification

```bash
python scripts/check_contracts.py
python -m unittest discover -s tests -v
terraform fmt -check -recursive modules examples
cd examples/consumer_v1 && terraform init -backend=false && terraform test
```

The CI matrix validates all three consumer examples. The Python compatibility scanner detects removed inputs, newly mandatory inputs, and removed outputs; it also verifies that contract metadata matches the HCL source. Metadata and syntax tests do not prove behavioral backward compatibility for AWS or other cloud resources, so a production module upgrade still requires Terraform plan review and migration evidence.

No infrastructure has been deployed to a cloud account.
