variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The GCP zone"
  type        = string
  default     = "us-central1-a"
}

variable "environment" {
  description = "Environment name (e.g., develop, staging, production)"
  type        = string
  default     = "develop"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "gcp-poc"
}

variable "default_labels" {
  description = "Default labels to apply to all resources"
  type        = map(string)
  default = {
    environment = "develop"
    project     = "gcp-poc"
    managed-by  = "terraform"
  }
}

# VPC Variables
variable "vpc_name" {
  description = "Name of the VPC network"
  type        = string
  default     = "poc-vpc"
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

# Cloud SQL Variables
variable "db_instance_name" {
  description = "Name of the Cloud SQL instance"
  type        = string
  default     = "poc-db-instance"
}

variable "db_name" {
  description = "Name of the database"
  type        = string
  default     = "poc_database"
}

variable "db_user" {
  description = "Database user name"
  type        = string
  default     = "poc_user"
}

variable "db_tier" {
  description = "The machine type for the Cloud SQL instance"
  type        = string
  default     = "db-f1-micro"
}

# Cloud Storage Variables
variable "storage_bucket_name" {
  description = "Name of the Cloud Storage bucket"
  type        = string
  default     = null
}

variable "storage_location" {
  description = "Location of the Cloud Storage bucket"
  type        = string
  default     = "US"
}

# Artifact Registry Variables
variable "artifact_registry_repository" {
  description = "Name of the Artifact Registry repository"
  type        = string
  default     = "poc-repo"
}

variable "artifact_registry_format" {
  description = "Format of the Artifact Registry repository"
  type        = string
  default     = "DOCKER"
}

# Cloud Run Variables
variable "cloud_run_service_name" {
  description = "Name of the Cloud Run service"
  type        = string
  default     = "poc-service"
}

variable "cloud_run_image" {
  description = "Container image for Cloud Run service"
  type        = string
  default     = "gcr.io/cloudrun/hello"
}

variable "cloud_run_port" {
  description = "Port for the Cloud Run service"
  type        = number
  default     = 8080
}

variable "min_instances" {
  description = "Minimum number of instances for Cloud Run"
  type        = number
  default     = 0
}

variable "max_instances" {
  description = "Maximum number of instances for Cloud Run"
  type        = number
  default     = 10
}

variable "cpu_limit" {
  description = "CPU limit for Cloud Run containers"
  type        = string
  default     = "1000m"
}

variable "memory_limit" {
  description = "Memory limit for Cloud Run containers"
  type        = string
  default     = "512Mi"
}

variable "cpu_request" {
  description = "CPU request for Cloud Run containers (minimum guaranteed)"
  type        = string
  default     = "100m"
}

variable "memory_request" {
  description = "Memory request for Cloud Run containers (minimum guaranteed)"
  type        = string
  default     = "128Mi"
}

variable "cpu_idle" {
  description = "Enable CPU-based scaling to zero for Cloud Run"
  type        = bool
  default     = true
}

variable "startup_cpu_boost" {
  description = "Enable CPU boost during container startup for Cloud Run"
  type        = bool
  default     = true
}

variable "DB_HOST" {
  description = "External database host"
  type        = string
  default     = "mariadb"
}

variable "DB_PORT" {
  description = "External database port"
  type        = string
  default     = "3306"
}

variable "DB_NAME" {
  description = "External database name"
  type        = string
  default     = "pdf_ai_db"
}

variable "DB_USER" {
  description = "External database user"
  type        = string
  default     = "pdf_user"
}

variable "DB_PASSWORD" {
  description = "External database password"
  type        = string
  default     = "pdf_password"
  sensitive   = true
}

variable "SECRET_NAME" {
  description = "Secret Manager secret name"
  type        = string
  default     = "develop_poc-database"
}

# GitHub Variables for Workload Identity Federation
variable "github_repository_owner" {
  description = "GitHub repository owner (organization or user)"
  type        = string
}

variable "github_repositories" {
  description = "List of GitHub repository names that can use WIF"
  type        = list(string)
  default     = []
}