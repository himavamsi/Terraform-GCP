resource "google_compute_global_address" "mylb" {
  name = "${local.name}-mylb-static-ip"
}

resource "google_compute_backend_bucket" "mylb" {
  name = "${local.name}-mylb-backend-bucket"
  bucket_name = google_storage_bucket.my_bucket.name
}

resource "google_compute_url_map" "mylb" {
  name = "${local.name}-mylb-url"
  default_service = google_compute_backend_bucket.mylb.id
}

resource "google_compute_target_http_proxy" "mylb" {
  name = "${local.name}-mylb-http-proxy"
  url_map = google_compute_url_map.mylb.self_link
}

resource "google_compute_global_forwarding_rule" "mylb" {
  name = "${local.name}-mylb-fowarding-rule"
  ip_address = google_compute_global_address.mylb.address
  ip_protocol = "TCP"
  port_range = "80"
  target = google_compute_target_http_proxy.mylb.self_link
}