provider "google" {
  credentials = file("credentials.json")
  project     = "aulas-288410"
  region      = "us-central1"
}

resource "google_sql_database" "database" {
  name     = "my-database"
  instance = google_sql_database_instance.instance.name
}

resource "google_sql_database_instance" "instance" {
  name   = "my-database-instance"
  region = "us-central1"
  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_database" "database2" {
  name     = "my-database2"
  instance = google_sql_database_instance.instance2.name
}

resource "google_sql_database_instance" "instance2" {
  name   = "my-database-instance2"
  region = "us-central1"
  settings {
    tier = "db-f1-micro"
  }
}


resource "google_compute_instance" "default3" {
  name         = "standalone"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  tags = ["http-server", "https-server"]

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

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "sudo apt-get update; sudo apt-get install -y apache2 php"

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}

resource "google_compute_instance" "default2" {
  name         = "standalone2"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  tags = ["http-server", "https-server"]

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

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "sudo apt-get update; sudo apt-get install -y apache2 php"

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}

# resource "google_compute_firewall" "default" {
#   name    = "aula-firewall"
#   network = google_compute_network.default.name

#   allow {
#     protocol = "icmp"
#   }

#   allow {
#     protocol = "tcp"
#     ports    = ["80","443"]
#   }

#   source_tags = ["web"]
# }

# resource "google_compute_network" "default" {
#   name = "aula-network"
# }
