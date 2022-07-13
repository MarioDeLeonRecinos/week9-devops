resource "google_service_account" "default" {
  account_id   = var.service_account_name
  display_name = "${var.service_account_name} Kubernetes"
}

resource "google_service_account_iam_binding" "admin-account-iam" {
  service_account_id = google_service_account.default.name
  role = "roles/iam.serviceAccountUser"

  members = [
    "allUsers"
  ]
}

resource "google_container_cluster" "primary" {
  name = var.name

  remove_default_node_pool = true
  initial_node_count       = var.initial_node_count
  network                  = var.vpc_network
  release_channel {
    channel = "REGULAR"
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = var.name_node_pool
  initial_node_count = var.node_count
  cluster    = google_container_cluster.primary.name
  node_count = var.node_count
  version    = data.google_container_engine_versions.default.release_channel_default_version["STABLE"]

  node_config {
    preemptible  = true
    machine_type = var.machine_type

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.default.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    labels = var.labels

    tags = var.tags
  }
}