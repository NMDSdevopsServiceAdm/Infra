environment       = "benchmark"
app_runner_cpu    = "0.5 vCPU"
app_runner_memory = "1 GB"
rds_instance_class = "db.t3.small"
rds_allocated_storage = 20
multi_az = false
elasticache_node_type = "cache.t3.micro"
app_runner_min_container_instances_size = 1
app_runner_max_container_instances_size = 1
app_runner_max_concurrency = 200
rds_db_backup_retention_period = 7
domain_name = "benchmarks.ascwds.co.uk"
sfc_reports_instance_type = "t2.micro"