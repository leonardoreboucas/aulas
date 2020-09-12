# Scales up to 3 instances
provider "google" {
  credentials = file("../credentials.json")
  project     = "reboucas-lessons"
  region      = "us-central1"
}

resource "random_string" "random" {
  length = 4
  special = false
  upper = false
}


resource "random_string" "random2" {
  length = 4
  special = false
  upper = false
}


resource "random_string" "random3" {
  length = 4
  special = false
  upper = false
}

resource "google_compute_instance" "give-a-name-to-your-instance" {
  name         = "give-a-name-to-your-instance-${random_string.random.result}"
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

  metadata_startup_script = "curl https://raw.githubusercontent.com/leonardoreboucas/lessons/master/cloud/orchestrators/terraform/lesson5/initial_script.sh | sh 2>> /var/log/start-script.log"

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}

resource "google_compute_instance" "give-a-name-to-your-instance-2" {
  name         = "give-a-name-to-your-instance-${random_string.random2.result}"
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

  metadata_startup_script = "curl https://raw.githubusercontent.com/leonardoreboucas/lessons/master/cloud/orchestrators/terraform/lesson5/initial_script.sh | sh 2>> /var/log/start-script.log"

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}

resource "google_compute_instance" "give-a-name-to-your-instance-3" {
  name         = "give-a-name-to-your-instance-${random_string.random3.result}"
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

  metadata_startup_script = "curl https://raw.githubusercontent.com/leonardoreboucas/lessons/master/cloud/orchestrators/terraform/lesson5/initial_script.sh | sh 2>> /var/log/start-script.log"

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}

resource "google_compute_instance_group" "webservers" {
  name        = "app-sample-webserver-${random_string.random.result}${random_string.random2.result}${random_string.random3.result}s"
  description = "app-sample test instance group"

   instances = [
     google_compute_instance.give-a-name-to-your-instance.id,
     google_compute_instance.give-a-name-to-your-instance-2.id,
     google_compute_instance.give-a-name-to-your-instance-3.id,
   ]

  named_port {
    name = "http"
    port = "80"
  }

  named_port {
    name = "https"
    port = "8443"
  }

  zone = "us-central1-a"
}

resource "google_compute_global_forwarding_rule" "http" {
  name       = "forwarding-rules-${random_string.random.result}${random_string.random2.result}${random_string.random3.result}"
  target     = google_compute_target_http_proxy.default.id
  port_range = "80"
}

resource "google_compute_target_http_proxy" "default" {
  name    = "http-proxy-${random_string.random.result}${random_string.random2.result}${random_string.random3.result}"
  url_map = element(compact(concat(list(""), google_compute_url_map.default.*.self_link)), 0)
}

resource "google_compute_url_map" "default" {
  name            = "load-balancer-url-map-${random_string.random.result}${random_string.random2.result}${random_string.random3.result}"
  default_service = google_compute_backend_service.default.id
}

resource "google_compute_backend_service" "default" {
  name            = "backend-${random_string.random.result}${random_string.random2.result}${random_string.random3.result}"
  port_name       = "http"
  protocol        = "HTTP"
  timeout_sec     = "30"
  backend {
    group = google_compute_instance_group.webservers.id
  }
  health_checks   = [element(google_compute_http_health_check.default.*.self_link, 0)]
  security_policy = ""
  enable_cdn      = "false"
}

resource "google_compute_http_health_check" "default" {
  name         = "backend-hc-${random_string.random.result}${random_string.random2.result}${random_string.random3.result}"
  request_path = "/"
  port         = "80"
}

resource "google_compute_firewall" "default-hc" {
  name          = "firewall-default-${random_string.random.result}${random_string.random2.result}${random_string.random3.result}"
  network       = "default"
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
}

output "loadbalancer_ip_addr" {
  value = google_compute_global_forwarding_rule.http.ip_address
}
