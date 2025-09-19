# Service Account for Cloud Run with Cloud SQL access
resource "google_service_account" "cloud_run_sa" {
  account_id   = "${var.project_name}-${var.environment}-cr-sa"
  display_name = "Cloud Run Service Account for ${var.project_name}-${var.environment}"
  description  = "Service account for Cloud Run with Cloud SQL IAM access"
}

# IAM roles for the Cloud Run service account
resource "google_project_iam_member" "cloud_sql_client" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.cloud_run_sa.email}"
}

resource "google_project_iam_member" "cloud_sql_instance_user" {
  project = var.project_id
  role    = "roles/cloudsql.instanceUser"
  member  = "serviceAccount:${google_service_account.cloud_run_sa.email}"
}

# Secret Manager access for Cloud Run service account
resource "google_project_iam_member" "secret_manager_accessor" {
  project = var.project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${google_service_account.cloud_run_sa.email}"
}

# Simple Cloud Run service - additional resources can be added later if needed

resource "google_cloud_run_v2_service" "main" {
  name     = var.cloud_run_service_name
  location = var.region

  template {
    service_account = google_service_account.cloud_run_sa.email

    scaling {
      min_instance_count = var.min_instances
      max_instance_count = var.max_instances
    }

    vpc_access {
      connector = "projects/${var.project_id}/locations/${var.region}/connectors/${var.vpc_connector_name}"
      egress    = "PRIVATE_RANGES_ONLY"  # Tráfico a rangos privados a través de VPC
    }

    containers {
      image = var.cloud_run_image

      ports {
        container_port = var.cloud_run_port
      }

      resources {
        limits = {
          cpu    = var.cpu_limit
          memory = var.memory_limit
        }
        cpu_idle          = var.cpu_idle           # Escalamiento a 0 basado en CPU
        startup_cpu_boost = var.startup_cpu_boost  # Boost de CPU durante startup
      }

      # Environment variables for application
      env {
        name  = "ENV"
        value = var.environment
      }
      env {
        name  = "PROJECT_ID"
        value = var.project_id
      }
      env {
        name  = "REGION"
        value = var.region
      }

      # Database configuration variables
      env {
        name  = "USE_CLOUD_SQL"
        value = "false"
      }
      env {
        name  = "DB_HOST"
        value = var.DB_HOST
      }
      env {
        name  = "DB_PORT"
        value = var.DB_PORT
      }
      env {
        name  = "DB_NAME"
        value = var.DB_NAME
      }
      env {
        name  = "DB_USER"
        value = var.DB_USER
      }
      env {
        name  = "DB_PASSWORD"
        value = var.DB_PASSWORD
      }

      env {
        name  = "SECRET_NAME"
        value = var.SECRET_NAME
      }
    }
  }

  traffic {
    percent = 100
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
  }

  lifecycle {
    ignore_changes = [
      template[0].containers[0].image,  # Permitir que GitHub Actions actualice la imagen
    ]
  }
}

resource "google_cloud_run_service_iam_member" "public_access" {
  location = google_cloud_run_v2_service.main.location
  project  = google_cloud_run_v2_service.main.project
  service  = google_cloud_run_v2_service.main.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}