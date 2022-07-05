resource "google_project_service" "vm-api" {
  service  = "compute.googleapis.com"
}

resource "google_project_service" "dns-api" {
  service  = "dns.googleapis.com"
}
