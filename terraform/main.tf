provider "google" {
  credentials = "${file("${var.todo_credential_file}")}"
  project     = "${var.todo_project_id}"
  region      = "${var.todo_region}"
  zone        = "${var.todo_zone}"
}

terraform {
  backend "gcs" {
    credentials = "../ssl/account.json"
  }
}

data "terraform_remote_state" "todo-api" {
  backend = "gcs"

  config {
    bucket      = "${var.todo_bucket}"
    path        = "${var.todo_state_path}"
    project     = "${var.todo_project_id}"
    credentials = "${file("${var.todo_credential_file}")}"
  }
}
