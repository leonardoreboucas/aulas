# Simple Plugin Initialization
provider "google" {
  credentials = file("../credentials.json")
  project     = "leonardo-340217"
  region      = "us-central1"
}
