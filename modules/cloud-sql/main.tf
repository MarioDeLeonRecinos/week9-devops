
resource "google_compute_global_address" "private_ip_address" {
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.vpc_network
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = var.vpc_network
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "google_sql_database_instance" "instance" {
  name             = var.name
  database_version = var.database_version #"MYSQL_8_0"

  depends_on = [google_service_networking_connection.private_vpc_connection]
  settings {
    tier = var.database_tier #"db-f1-micro"
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc_network
    }
  }
}

resource "google_sql_user" "users" {
  name     = var.user
  instance = google_sql_database_instance.instance.name
  password = var.password
}