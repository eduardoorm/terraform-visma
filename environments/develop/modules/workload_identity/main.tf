resource "google_service_account" "github_actions" {
  account_id   = "${var.project_name}-${var.environment}-gh-actions"
  display_name = "GitHub Actions Service Account"
  description  = "Service account for GitHub Actions deployments"
}

resource "google_iam_workload_identity_pool" "github_pool" {
  workload_identity_pool_id = "${var.environment}-github-actions-pool"
  display_name              = "GitHub Actions Pool"
  description               = "Workload Identity Pool for GitHub Actions"
}

resource "google_iam_workload_identity_pool_provider" "github_provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.github_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "${var.environment}-github-provider"
  display_name                       = "GitHub Actions Provider"
  description                        = "Workload Identity Pool Provider for GitHub Actions"

  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.repository" = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
  }

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }

  attribute_condition = "assertion.repository_owner == '${var.github_repository_owner}'"
}

resource "google_service_account_iam_member" "github_actions_workload_identity" {
  for_each = toset(var.github_repositories)

  service_account_id = google_service_account.github_actions.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_pool.name}/attribute.repository/${var.github_repository_owner}/${each.value}"
}

# Get project data for default Cloud Build service account
data "google_project" "project" {
  project_id = var.project_id
}

# GitHub Actions service account - Editor role for POC simplicity
resource "google_project_iam_member" "github_actions_editor" {
  project = var.project_id
  role    = "roles/editor"
  member  = "serviceAccount:${google_service_account.github_actions.email}"
}

# Default Cloud Build service account - Editor role (used by gcloud run deploy --source)
resource "google_project_iam_member" "default_cloudbuild_editor" {
  project = var.project_id
  role    = "roles/editor"
  member  = "serviceAccount:${data.google_project.project.number}@cloudbuild.gserviceaccount.com"
}

