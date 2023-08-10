terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.77.0"
    }
  }
}

provider "google" {
  credentials = file("credentials.json")
  project     = "finkuapp"
  region      = "asia-southeast2"
}
