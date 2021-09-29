# Simple Plugin Initialization
provider "google" {
  credentials = file("../credentials.json")
  project     = "aula-unb-2909"
  region      = "us-central1"
}