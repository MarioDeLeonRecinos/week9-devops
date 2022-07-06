resource "google_dns_managed_zone" "default" {
  name        = var.name
  dns_name    = var.dns_name
  description = "Module generated DNS zone ${var.name}"

  visibility = "public"

  labels = var.labels
}

resource "google_compute_global_address" "default" {
  name         = "reserved-ip-default"
  address_type = "EXTERNAL"
}

resource "google_dns_record_set" "www-default" {
  name       = "www.${google_dns_managed_zone.default.dns_name}"
  type       = "CNAME"
  ttl        = 300

  managed_zone = google_dns_managed_zone.default.name

  rrdatas = [google_dns_managed_zone.default.dns_name]
}

resource "google_dns_record_set" "default" {
  name       = google_dns_managed_zone.default.dns_name
  type       = "A"
  ttl        = 300

  managed_zone = google_dns_managed_zone.default.name

  rrdatas = [google_compute_global_address.default.address]
}

resource "google_dns_record_set" "subdomains" {
  for_each     = var.subdomain
  name       = "${each.value}.${google_dns_managed_zone.default.dns_name}"
  type       = "A"
  ttl        = 300

  managed_zone = google_dns_managed_zone.default.name

  rrdatas = [google_compute_global_address.default.address]
}