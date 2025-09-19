output "workload_identity_provider" {
  description = "Workload Identity Provider for GitHub Actions (WIF_PROVIDER secret)"
  value       = google_iam_workload_identity_pool_provider.github_provider.name
}

output "service_account_email" {
  description = "Service account email for GitHub Actions (WIF_SERVICE_ACCOUNT secret)"
  value       = google_service_account.github_actions.email
}

output "github_actions_sa_name" {
  description = "GitHub Actions service account name"
  value       = google_service_account.github_actions.name
}

