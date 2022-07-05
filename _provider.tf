terraform {
  required_providers {
    google = {
      source = "hashicorp/google"

    }
  }

  backend "gcs" {
    bucket = "week8-355318"
    prefix = "terraform/state"
  }
}
provider "google" {
  version = "4.26.0"
  project = "week8-355318"
  region  = "us-west1"
  zone    = "us-west1-c"
}