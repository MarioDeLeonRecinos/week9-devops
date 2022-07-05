variable "services" {
  type    = list(string)
  default = ["compute.googleapis.com","dns.googleapis.com", "container.googleapis.com"]
}

