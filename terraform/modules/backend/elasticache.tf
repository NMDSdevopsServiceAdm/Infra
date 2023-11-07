resource "aws_elasticache_subnet_group" "sfc_redis_elasticache_subnet_group" {
  name       = "sfc-vpc"
  subnet_ids = var.private_subnet_ids
}

resource "aws_elasticache_replication_group" "sfc_redis_replication_group" {
  replication_group_id        = "sfc-redis"
  description                 = "sfc-redis"
  node_type                   = var.elasticache_node_type
  num_cache_clusters          = 1
  parameter_group_name        = "default.redis7"
  port                        = 6379
  subnet_group_name  = aws_elasticache_subnet_group.sfc_redis_elasticache_subnet_group.name
  security_group_ids = var.security_group_ids
  apply_immediately = true

  lifecycle {
    ignore_changes = [num_cache_clusters]
  }
}

resource "aws_elasticache_cluster" "sfc_redis_replica" {
  count = 1
  cluster_id           = "sfc-redis-${var.environment}-${count.index}"
  replication_group_id = aws_elasticache_replication_group.sfc_redis_replication_group.id
  apply_immediately = true
}