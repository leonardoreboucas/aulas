# Simple Plugin Initialization
provider "google" {
  credentials = file("../credentials.json")
  project     = "reboucas-lessons"
  region      = "us-central1"
}