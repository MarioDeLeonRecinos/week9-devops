resource "google_compute_network" "vpc_network" {
  name                    = "vpc-network"
  auto_create_subnetworks = true
  mtu                     = 1460
}

module "dns-provider"{
  source = "./modules/dns-provider"

  name = "Week 8"
  dns_name = "week8challenge.tk."
  labels = {
    creator = "mario",
    owner = "mario"
  }
  subdomain = ["dash", "monitor"]
}

resource "google_service_account" "default" {
  account_id   = "service-account-id"
  display_name = "Service Account Kubernetes"
}

resource "google_container_cluster" "primary" {
  name       = "my-gke-cluster"

  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = google_compute_network.vpc_network.name
  release_channel {
    channel = "REGULAR"
  }
}

data "google_container_engine_versions" "default" {
  version_prefix = "1.24."
}

output "stable_channel_version" {
  value = data.google_container_engine_versions.default.release_channel_default_version["STABLE"]
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  cluster    = google_container_cluster.primary.name
  node_count = 2
  version    = data.google_container_engine_versions.default.release_channel_default_version["STABLE"]

  node_config {
    preemptible  = true
    machine_type = "e2-small"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.default.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}