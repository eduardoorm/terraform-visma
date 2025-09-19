resource "google_artifact_registry_repository" "main" {
  repository_id = var.artifact_registry_repository
  location      = var.region
  format        = var.artifact_registry_format
  description   = "Docker repository for ${var.project_name} ${var.environment} environment"

  cleanup_policies {
    id     = "delete-old-images"
    action = "DELETE"
    condition {
      tag_state  = "UNTAGGED"
      older_than = "2592000s" # 30 days
    }
  }

  cleanup_policies {
    id     = "keep-minimum-versions"
    action = "KEEP"
    most_recent_versions {
      keep_count = 10
    }
  }
}

# Cloud Run source deploy repository already exists automatically