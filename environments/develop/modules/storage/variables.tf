variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

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