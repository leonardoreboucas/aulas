# Make Apache acessible via external IP and firewall rules
provider "google" {
  credentials = file("../credentials.json")
  project     = "aula-unb-2909"
  region      = "us-central1"
}

resource "google_compute_instance" "give-a-name-to-your-instance" {
  name         = "give-a-name-to-your-instance"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  tags = ["web"]

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

resource "google_compute_firewall" "rules" {
  name        = "my-firewall-rule"
  network     = "default"
  description = "Creates firewall rule targeting tagged instances"

  allow {
    protocol  = "tcp"
    ports     = ["80", "8080", "1000-2000"]
  }
  target_tags = ["web"]
}