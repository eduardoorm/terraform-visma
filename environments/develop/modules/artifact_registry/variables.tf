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

variable "artifact_registry_repository" {
  description = "Name of the Artifact Registry repository"
  type        = string
}

variable "artifact_registry_format" {
  description = "Format of the Artifact Registry repository"
  type        = string
}

