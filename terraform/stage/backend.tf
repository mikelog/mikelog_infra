terraform {
  backend "gcs" {
    bucket = "storage-bucket-stage"
    prefix = "stage"
  }
}
