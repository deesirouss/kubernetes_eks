#module "mysql_rds" {
#  source     = "../../common/rds"
#  identifier = join("", ["prod-vyaguta", local.stage])
#
#  engine            = "mysql"
#  engine_version    = "8.0.20"
#  instance_class    = "db.t3.small"
#  allocated_storage = 10
#  storage_encrypted = true
#  kms_key_id        = module.kms.kms_key_arn
#  name              = "vyaguta-test"
#  # NOTE: Do NOT use 'user' as the value for 'username' as it throws:
#  # "Error creating DB Instance: InvalidParameterValue: MasterUsername
#  # user cannot be used as it is a reserved word used by the engine"
#  username               = var.rds_credentials.username
#  password               = var.rds_credentials.password
#  port                   = "3306"
#  vpc_security_group_ids = [module.vpc_demo.vpc_security_group_id]
#  maintenance_window     = "Mon:00:00-Mon:03:00"
#  backup_window          = "03:00-06:00"
#  # disable backups to create DB faster
#  backup_retention_period         = 30
#  tags                            = module.label.tags
#  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
#  # DB subnet group
#  subnet_ids = module.vpc_demo.private_subnet_ids
#  # DB parameter group
#  family = "mysql8.0"
#  # DB option group
#  major_engine_version = "8.0"
#  # Snapshot name upon DB deletion
#  final_snapshot_identifier = "demodb"
#  # Database Deletion Protection
#  deletion_protection        = false
#  multi_az                   = false
#  auto_minor_version_upgrade = false
#  apply_immediately          = true
#
#}
#
#module "postgres_rds" {
#  source     = "../../common/rds"
#  identifier = join("", ["prod-vyaguta-postgres", local.stage])
#
#  engine            = "postgres"
#  engine_version    = "8.0.20"
#  instance_class    = "db.t3.small"
#  allocated_storage = 10
#  storage_encrypted = true
#  kms_key_id        = module.kms.kms_key_arn
#  name              = "vyaguta-postgres-test"
#  # NOTE: Do NOT use 'user' as the value for 'username' as it throws:
#  # "Error creating DB Instance: InvalidParameterValue: MasterUsername
#  # user cannot be used as it is a reserved word used by the engine"
#  username               = var.rds_credentials.username
#  password               = var.rds_credentials.password
#  port                   = "3306"
#  vpc_security_group_ids = [module.vpc_demo.vpc_security_group_id]
#  maintenance_window     = "Mon:00:00-Mon:03:00"
#  backup_window          = "03:00-06:00"
#  # disable backups to create DB faster
#  backup_retention_period         = 30
#  tags                            = local.tags
#  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
#  # DB subnet group
#  subnet_ids = module.vpc_demo.private_subnet_ids
#  # DB parameter group
#  family = "mysql8.0"
#  # DB option group
#  major_engine_version = "8.0"
#  # Snapshot name upon DB deletion
#  final_snapshot_identifier = "demodb"
#  # Database Deletion Protection
#  deletion_protection        = false
#  multi_az                   = false
#  auto_minor_version_upgrade = false
#  apply_immediately          = true
#
#}