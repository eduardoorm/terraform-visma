output "project_id" {
  description = "The GCP project ID"
  value       = var.project_id
}

output "region" {
  description = "The GCP region"
  value       = var.region
}

output "environment" {
  description = "The environment name"
  value       = var.environment
}

# VPC Outputs
output "vpc_name" {
  description = "Name of the VPC network"
  value       = module.vpc.vpc_name
}

output "vpc_id" {
  description = "ID of the VPC network"
  value       = module.vpc.vpc_id
}

output "subnet_name" {
  description = "Name of the subnet"
  value       = module.vpc.subnet_name
}

output "subnet_cidr" {
  description = "CIDR block of the subnet"
  value       = module.vpc.subnet_cidr
}

# Cloud SQL Outputs (commented until SQL module is enabled)
# output "db_instance_name" {
#   description = "Name of the Cloud SQL instance"
#   value       = module.sql.db_instance_name
# }

# Cloud Storage Outputs
output "storage_bucket_name" {
  description = "Name of the main Cloud Storage bucket"
  value       = module.storage.main_bucket_name
}

output "storage_bucket_url" {
  description = "URL of the main Cloud Storage bucket"
  value       = module.storage.main_bucket_url
}


# Artifact Registry Outputs
output "artifact_registry_repository_name" {
  description = "Name of the Artifact Registry repository"
  value       = module.artifact_registry.repository_name
}

output "artifact_registry_repository_url" {
  description = "URL of the Artifact Registry repository"
  value       = module.artifact_registry.repository_url
}

# Cloud Run Outputs
output "cloud_run_service_name" {
  description = "Name of the Cloud Run service"
  value       = module.cloud_run.service_name
}

output "cloud_run_service_url" {
  description = "URL of the Cloud Run service"
  value       = module.cloud_run.service_url
}

# Cloud Run service account output (commented out - not available in simplified module)
# output "cloud_run_service_account_email" {
#   description = "Email of the Cloud Run service account"
#   value       = module.cloud_run.service_account_email
# }

# VPC Access Connector Output
output "vpc_connector_name" {
  description = "Name of the VPC Access Connector"
  value       = module.vpc.vpc_connector_name
}

# Secret Manager Outputs (commented until SQL module is enabled)
# output "db_password_secret_name" {
#   description = "Name of the database password secret"
#   value       = module.cloud_run.db_password_secret_name
# }

# Workload Identity Federation Outputs
output "wif_provider" {
  description = "Workload Identity Provider for GitHub Actions (use as WIF_PROVIDER secret)"
  value       = module.workload_identity.workload_identity_provider
}

output "wif_service_account" {
  description = "Service account email for GitHub Actions (use as WIF_SERVICE_ACCOUNT secret)"
  value       = module.workload_identity.service_account_email
}