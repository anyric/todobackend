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

  scratch_disk {}

  network_interface {
    network = "default"

    access_config {}
  }

  metadata {
    todobackend = "api"
  }

  metadata_startup_script = "/home/todo/todobackend/start_app.sh"

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