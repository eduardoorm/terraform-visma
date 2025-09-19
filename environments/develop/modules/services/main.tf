resource "google_project_service" "compute" {
  service = "compute.googleapis.com"

  disable_dependent_services = true
}

resource "google_project_service" "storage" {
  service = "storage.googleapis.com"

  disable_dependent_services = true
}

resource "google_project_service" "sqladmin" {
  service = "sqladmin.googleapis.com"

  disable_dependent_services = true
}

resource "google_project_service" "servicenetworking" {
  service = "servicenetworking.googleapis.com"

  disable_dependent_services = true
}

resource "google_project_service" "artifactregistry" {
  service = "artifactregistry.googleapis.com"

  disable_dependent_services = true
}

resource "google_project_service" "run" {
  service = "run.googleapis.com"

  disable_dependent_services = true
}

resource "google_project_service" "vpcaccess" {
  service = "vpcaccess.googleapis.com"

  disable_dependent_services = true
}

resource "google_project_service" "secretmanager" {
  service = "secretmanager.googleapis.com"

  disable_dependent_services = true
}

resource "google_project_service" "iam" {
  service = "iam.googleapis.com"

  disable_dependent_services = true
}

resource "google_project_service" "cloudresourcemanager" {
  service = "cloudresourcemanager.googleapis.com"

  disable_dependent_services = true
}

resource "google_project_service" "cloudbuild" {
  service = "cloudbuild.googleapis.com"

  disable_dependent_services = true
}

resource "google_project_service" "container" {
  service = "container.googleapis.com"

  disable_dependent_services = true
}

resource "google_project_service" "containerregistry" {
  service = "containerregistry.googleapis.com"

  disable_dependent_services = true
}

