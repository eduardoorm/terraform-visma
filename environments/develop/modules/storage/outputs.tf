output "main_bucket_name" {
  description = "Name of the main Cloud Storage bucket"
  value       = google_storage_bucket.main.name
}

output "main_bucket_url" {
  description = "URL of the main Cloud Storage bucket"
  value       = google_storage_bucket.main.url
}