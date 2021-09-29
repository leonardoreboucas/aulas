# Install Apache on VM
provider "google" {
  credentials = file("../credentials.json")
  project     = "aula-unb-2909"
  region      = "us-central1"
}

resource "google_compute_instance" "give-a-name-to-your-instance" {
  name         = "give-a-name-to-your-instance"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"
     access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = "sudo apt-get update; sudo apt-get install -y apache2"

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}