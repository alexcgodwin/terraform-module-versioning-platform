# Migration from module v1.1 to v2

1. Pin the existing module version and back up state in an approved encrypted backend.
2. Identify all consumers of `service_name`, `service_id` and `module.service` addresses.
3. Update `service_name` to `workload_id`; add required `owner`.
4. Update references to `service_id` to `workload_ref`.
5. For a module address rename, use a version-controlled `moved` block if supported or coordinate a state migration with exclusive locking.
6. Execute a non-destructive plan and investigate any proposed replacement before approval.
7. Roll out dev, stage, production sequentially and pin an immutable v2 tag after release.

No cloud resources are managed by the sample `terraform_data` contracts, and no live upgrade has been performed here.
