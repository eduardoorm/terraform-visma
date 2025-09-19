variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "cloud_run_service_name" {
  description = "Name of the Cloud Run service"
  type        = string
}

variable "cloud_run_image" {
  description = "Container image for Cloud Run service"
  type        = string
}

variable "cloud_run_port" {
  description = "Port for the Cloud Run service"
  type        = number
}

variable "vpc_network" {
  description = "VPC network object (optional)"
  type        = any
  default     = null
}

variable "vpc_connector_name" {
  description = "VPC Access Connector name for Cloud Run"
  type        = string
}

variable "storage_bucket_name" {
  description = "Storage bucket name (optional)"
  type        = string
  default     = ""
}

variable "min_instances" {
  description = "Minimum number of instances"
  type        = number
  default     = 0
}

variable "max_instances" {
  description = "Maximum number of instances"
  type        = number
  default     = 10
}

variable "cpu_limit" {
  description = "CPU limit (e.g., '1000m', '2')"
  type        = string
  default     = "1000m"
}

variable "memory_limit" {
  description = "Memory limit (e.g., '512Mi', '1Gi')"
  type        = string
  default     = "512Mi"
}

variable "cpu_request" {
  description = "CPU request (minimum CPU guaranteed)"
  type        = string
  default     = "100m"
}

variable "memory_request" {
  description = "Memory request (minimum memory guaranteed)"
  type        = string
  default     = "128Mi"
}

variable "cpu_idle" {
  description = "Enable CPU-based scaling to zero"
  type        = bool
  default     = true
}

variable "startup_cpu_boost" {
  description = "Enable CPU boost during container startup"
  type        = bool
  default     = true
}

variable "db_instance_name" {
  description = "Cloud SQL instance name"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "DB_HOST" {
  description = "Database host"
  type        = string
  default     = "mariadb"
}

variable "DB_PORT" {
  description = "Database port"
  type        = string
  default     = "3306"
}

variable "DB_NAME" {
  description = "Database name for external DB"
  type        = string
  default     = "pdf_ai_db"
}

variable "DB_USER" {
  description = "Database user for external DB"
  type        = string
  default     = "pdf_user"
}

variable "DB_PASSWORD" {
  description = "Database password for external DB"
  type        = string
  default     = "pdf_password"
  sensitive   = true
}

variable "SECRET_NAME" {
  description = "Secret Manager secret name"
  type        = string
  default     = "develop_poc-database"
}