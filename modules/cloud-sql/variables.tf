variable "name" {
  description = "Name of the resource"
  type        = string
}

variable "vpc_network" {
  description = "Name of network."
  type        = string
}

variable "database_version" {
  description = "Database version to set."
  type        = string
}

variable "database_tier" {
  description = "Database Tier to set."
  type        = string
}

variable "user" {
  description = "Name for user."
  type        = string
}

variable "password" {
  description = "Password for user."
  type        = string
}
