resource "google_compute_instance" "default" {
  name         = "anyric-lms-output"
  machine_type = "n1-standard-1"
  zone         = "europe-west1-b"

  tags = ["todobackend", "api"]

  boot_disk {
    initialize_params {
      image = "${var.todo_disk_image}"
    }
  }

  // Local SSD disk
  scratch_disk {
  }

  network_interface {
    network = "default"

    access_config {
      # nat_ip = "${google_compute_address.web.address}"
    }
  }

  metadata {
    todobackend = "api"
  }

  metadata_startup_script = "echo hi > /test.txt"

  lifecycle {
    create_before_destroy = true
  }

  service_account {
    scopes = [
      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/logging.read",
      "https://www.googleapis.com/auth/logging.write",
    ]
  }
}