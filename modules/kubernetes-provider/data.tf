
data "google_container_engine_versions" "default" {
  version_prefix = "1.24."
}

data "google_iam_policy" "admin" {
  binding {
    role = "roles/container.admin"

    members = [
      "allUsers"
    ]
  }
}