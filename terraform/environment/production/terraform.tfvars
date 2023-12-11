environment       = "prod"
app_runner_cpu    = "1 vCPU"
app_runner_memory = "2 GB"
rds_instance_class = "db.t3.2xlarge"
rds_allocated_storage = 200
multi_az = true
elasticache_node_type = "cache.t3.micro"
app_runner_min_container_instances_size = 2
app_runner_max_container_instances_size = 25
app_runner_max_concurrency = 200
rds_db_backup_retention_period = 35
domain_name = "asc-wds.skillsforcare.org.uk"
sfc_reports_instance_type = "t3.large"