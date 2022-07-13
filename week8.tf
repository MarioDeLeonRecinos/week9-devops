resource "google_compute_network" "vpc_network" {
  name                    = "vpc-network"
  auto_create_subnetworks = true
  mtu                     = 1460
}

module "dns-provider" {
  source = "./modules/dns-provider"

  name     = "week-9"
  dns_name = "week9challenge.tk."
  labels = {
    creator = "mario",
    owner   = "mario"
  }
  subdomain = ["dash", "monitor","argo","vault"]
}

module "kubernetes-provider" {
  source = "./modules/kubernetes-provider"

  name                 = "my-gke-cluster"
  name_node_pool       = "my-node-pool"
  service_account_name = "service-account-id"
  machine_type         = "e2-medium"
  initial_node_count   = 1
  node_count           = 3
  vpc_network          = google_compute_network.vpc_network.name
  labels = {
    creator = "mario",
    owner   = "mario"
  }
  tags = ["creator", "owner","mario"]
}

module "cloud-sql" {
  source = "./modules/cloud-sql"

  name             = "my-private-db"
  database_version = "MYSQL_8_0"
  database_tier    = "db-f1-micro"
  vpc_network      = google_compute_network.vpc_network.id
  user             = "wp-user"
  password         = "wp-password"
}