resource "google_project_service" "dns-api" {
  service  = "dns.googleapis.com"
}

#resource "google_project_service" "kubernetes-api" {
#  service  = "container.googleapis.com"
#}

resource "google_compute_network" "vpc_network" {
  name                    = "vpc-network"
  auto_create_subnetworks = true
  mtu                     = 1460
}

resource "google_dns_managed_zone" "default" {
  name        = "week8"
  dns_name    = "week8challenge.tk."
  description = "Week 8 DNS"

  visibility = "public"
}

# reserved IP address
resource "google_compute_global_address" "default" {
  name         = "default-ip-reserved"
  address_type = "EXTERNAL"
}

resource "google_dns_record_set" "www-default" {
  name = "www.${google_dns_managed_zone.default.dns_name}"
  type = "CNAME"
  ttl  = 300

  managed_zone = google_dns_managed_zone.default.name

  rrdatas = [google_dns_managed_zone.default.dns_name]
}

resource "google_dns_record_set" "default" {
  name = google_dns_managed_zone.default.dns_name
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.default.name

  rrdatas = [google_compute_global_address.default.address] //google_compute_instance.frontend.network_interface[0].access_config[0].nat_ip
}
