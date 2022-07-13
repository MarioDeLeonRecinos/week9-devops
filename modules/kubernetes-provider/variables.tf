variable "name" {
  description = "Name of the cluster"
  type        = string
}

variable "name_node_pool" {
  description = "Name of the node pool"
  type        = string
}

variable "node_count" {
  description = "Number of nodes"
  type        = number
}

variable "initial_node_count"{
  description = "Number of nodes at start"
  type        = number
}

variable "service_account_name" {
  description = "Name of the resource"
  type        = string
}

variable "machine_type" {
  description = "Name of the machine type"
  type        = string
}

variable "vpc_network" {
  description = "Name of the network used. Must be unique."
  type        = string
}

variable "labels" {
  description = "Labels to set."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "tags to set."
  type        = set(string)
  default     = []
}