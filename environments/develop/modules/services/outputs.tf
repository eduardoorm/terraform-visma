output "enabled_services" {
  description = "List of enabled Google Cloud services"
  value = [
    google_project_service.compute.service,
    google_project_service.storage.service,
    google_project_service.sqladmin.service,
    google_project_service.servicenetworking.service,
    google_project_service.artifactregistry.service,
    google_project_service.run.service,
    google_project_service.vpcaccess.service,
    google_project_service.secretmanager.service,
    google_project_service.iam.service,
    google_project_service.cloudresourcemanager.service
  ]
}