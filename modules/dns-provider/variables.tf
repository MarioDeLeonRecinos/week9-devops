variable "name" {
  description = "Name of the resource"
  type        = string
}

variable "dns_name" {
  description = "Name of the dns used. Must be unique."
  type        = string
}

variable "labels" {
  description = "Labels to set."
  type        = map(string)
  default     = {}
}

variable "subdomain" {
  description = "Subdomains to set."
  type        = set(string)
  default     = []
}