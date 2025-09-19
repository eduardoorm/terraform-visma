# Enable required Google Cloud services
module "services" {
  source = "./modules/services"

  project_id = var.project_id
}

# Create VPC network and networking components
module "vpc" {
  source = "./modules/vpc"

  project_id    = var.project_id
  project_name  = var.project_name
  environment   = var.environment
  vpc_name      = var.vpc_name
  subnet_cidr   = var.subnet_cidr
  region        = var.region

  depends_on = [module.services]
}

# Create Cloud Storage buckets
module "storage" {
  source = "./modules/storage"

  project_name         = var.project_name
  environment          = var.environment
  storage_bucket_name  = var.storage_bucket_name
  storage_location     = var.storage_location

  # depends_on = [module.services]
}

# Create Artifact Registry repository
module "artifact_registry" {
  source = "./modules/artifact_registry"

  project_id                   = var.project_id
  project_name                 = var.project_name
  environment                  = var.environment
  region                       = var.region
  artifact_registry_repository = var.artifact_registry_repository
  artifact_registry_format    = var.artifact_registry_format

  depends_on = [module.services]
}

# Create Workload Identity Federation for GitHub Actions
module "workload_identity" {
  source = "./modules/workload_identity"

  project_id              = var.project_id
  project_name            = var.project_name
  environment             = var.environment
  github_repository_owner = var.github_repository_owner
  github_repositories     = var.github_repositories

  depends_on = [module.services, module.artifact_registry]
}

# Create Cloud SQL instance
module "sql" {
  source = "./modules/sql"

  project_id       = var.project_id
  project_name     = var.project_name
  environment      = var.environment
  region           = var.region
  db_instance_name = var.db_instance_name
  db_name          = var.db_name
  db_user          = var.db_user
  db_tier          = var.db_tier
  vpc_network      = module.vpc.vpc_network

  depends_on = [module.vpc, module.services]
}

# Create Cloud Run service (importing existing)
module "cloud_run" {
  source = "./modules/cloud_run"

  project_id              = var.project_id
  project_name            = var.project_name
  environment             = var.environment
  region                  = var.region
  cloud_run_service_name  = var.cloud_run_service_name
  cloud_run_image         = var.cloud_run_image
  cloud_run_port          = var.cloud_run_port
  vpc_network             = module.vpc.vpc_network
  vpc_connector_name      = module.vpc.vpc_connector_name
  storage_bucket_name     = module.storage.main_bucket_name
  min_instances           = var.min_instances
  max_instances           = var.max_instances
  cpu_limit               = var.cpu_limit
  memory_limit            = var.memory_limit
  cpu_request             = var.cpu_request
  memory_request          = var.memory_request
  cpu_idle                = var.cpu_idle
  startup_cpu_boost       = var.startup_cpu_boost
  db_instance_name        = var.db_instance_name
  db_name                 = var.db_name
  DB_HOST                 = var.DB_HOST
  DB_PORT                 = var.DB_PORT
  DB_NAME                 = var.DB_NAME
  DB_USER                 = var.DB_USER
  DB_PASSWORD             = var.DB_PASSWORD
  SECRET_NAME             = var.SECRET_NAME

  depends_on = [module.vpc, module.storage, module.services, module.sql]
}

# IAM database user for Cloud Run service account
resource "google_sql_user" "cloud_run_iam_user" {
  name     = module.cloud_run.service_account_email
  instance = module.sql.db_instance_name
  type     = "CLOUD_IAM_SERVICE_ACCOUNT"

  depends_on = [module.sql, module.cloud_run]
}