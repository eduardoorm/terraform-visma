resource "random_id" "bucket_suffix" {
  byte_length = 8
}

resource "google_storage_bucket" "main" {
  name          = var.storage_bucket_name != null ? var.storage_bucket_name : "${var.project_name}-${var.environment}-bucket-${random_id.bucket_suffix.hex}"
  location      = var.storage_location
  force_destroy = true
}