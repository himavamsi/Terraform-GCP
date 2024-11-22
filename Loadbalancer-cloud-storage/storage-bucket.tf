resource "google_storage_bucket" "my_bucket" {
  name = "${local.name}-myapp1-bucket"
  versioning {
    enabled = false
  }
  location = var.region
  storage_class = "STANDARD"
  website {
    main_page_suffix = "index.html"
  }
}

resource "google_storage_bucket_object" "my_object" {
  name = "index.html"
  bucket = google_storage_bucket.my_bucket.name
  source = "local/index.html"
  storage_class = "REGIONAL"
}

resource "google_storage_bucket_iam_member" "iam" {
  bucket = google_storage_bucket.my_bucket.self_link
  role = "roles/storage.objectViewer"
  member = "allUsers"
}