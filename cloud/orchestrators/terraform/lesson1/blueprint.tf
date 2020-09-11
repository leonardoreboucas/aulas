# Simple Plugin Initialization
provider "google" {
  credentials = file("../credentials.json")
  project     = "aulas-288410"
  region      = "us-central1"
}