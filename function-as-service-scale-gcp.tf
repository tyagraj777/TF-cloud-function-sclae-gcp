provider "google" {
  project = "cool-agility-442507-c5"
  region  = "us-west1"
}

resource "google_storage_bucket" "function_bucket" {
  name          = "cloud-function-bucket-${random_id.id.hex}"
  location      = "US"
  force_destroy = true
}

resource "random_id" "id" {
  byte_length = 4
}

resource "google_cloudfunctions_function" "scaling_function" {
  name        = "scaling-function"
  description = "Cloud Function scaling based on load"
  runtime     = "nodejs16"
  entry_point = "handler"
  available_memory_mb = 256
  source_archive_bucket = google_storage_bucket.function_bucket.name
  source_archive_object = "${google_storage_bucket_object.function_code.name}"
  trigger_http          = true
  https_trigger_security_level = "SECURE_ALWAYS"

  environment_variables = {
    NODE_ENV = "production"
  }
}

resource "google_storage_bucket_object" "function_code" {
  name   = "function-source.zip"
  bucket = google_storage_bucket.function_bucket.name
  source = "function-source.zip"
}

output "function_url" {
  value = google_cloudfunctions_function.scaling_function.https_trigger_url
}

