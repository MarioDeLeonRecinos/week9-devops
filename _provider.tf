terraform {
  required_providers {
    google = {
      source = "hashicorp/google"

    }
  }

  backend "gcs" {
    bucket = "week9-356019"
    prefix = "terraform/state"
  }
}
provider "google" {
  version = "4.27.0"
  project = "week9-356019"
  region  = "us-west1"
  zone    = "us-west1-c"
}