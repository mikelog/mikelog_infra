terraform {
  backend "gcs" {
    bucket = "storage-bucket-prod"
    prefix = "stage"
  }
}
