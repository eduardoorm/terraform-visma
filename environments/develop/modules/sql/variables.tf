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

variable "db_instance_name" {
  description = "Name of the Cloud SQL instance"
  type        = string
}

variable "db_name" {
  description = "Name of the database"
  type        = string
}

variable "db_user" {
  description = "Database user name"
  type        = string
}

variable "db_tier" {
  description = "The machine type for the Cloud SQL instance"
  type        = string
}

variable "vpc_network" {
  description = "VPC network object"
  type        = any
}

