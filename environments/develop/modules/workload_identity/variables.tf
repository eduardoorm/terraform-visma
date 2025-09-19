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

variable "github_repository_owner" {
  description = "GitHub repository owner (organization or user)"
  type        = string
}

variable "github_repositories" {
  description = "List of GitHub repository names that can use WIF"
  type        = list(string)
}