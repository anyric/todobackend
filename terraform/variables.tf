

variable "todo_bucket" {
  type = "string"
  default = "anyric-lms-output"
}

variable "todo_project_id" {
  type    = "string"
  default = "andela-learning"
}

variable "todo_credential_file" {
  type    = "string"
  default = "../ssl/account.json"
}

variable "todo_state_path" {
  type = "string"
  default = "terraform/state/terraform.tfstate"
}


variable "todo_disk_image" {
  type = "string"
  default ="ubuntu-1604-xenial-v20170815a"
}

variable "todo_region" {
  type    = "string"
  default = "europe-west1"
}

variable "todo_zone" {
  type       = "string"
  default    = "europe-west1-b"
}


