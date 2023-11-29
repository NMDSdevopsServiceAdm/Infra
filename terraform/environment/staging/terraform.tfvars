environment                             = "staging"
app_runner_cpu                          = "0.25 vCPU"
app_runner_memory                       = "0.5 GB"
rds_instance_class                      = "db.t3.small"
rds_allocated_storage                   = 20
multi_az                                = false
elasticache_node_type                   = "cache.t3.micro"
app_runner_min_container_instances_size = 1
app_runner_max_container_instances_size = 1
app_runner_max_concurrency              = 200
rds_db_backup_retention_period          = 7
