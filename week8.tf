resource "google_project_service" "dns-api" {
  service  = "dns.googleapis.com"
}

resource "google_project_service" "kubernetes-api" {
  service  = "container.googleapis.com"
}
