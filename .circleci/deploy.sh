#!/bin/bash

set -ex
set -o pipefail

ls /home/circleci/todobackend
create_service_account() {
  mkdir -p /home/circleci/todobackend
  git clone -b master ${INFRASTRUCTURE_REPO} /home/circleci/todobackend
  touch /home/circleci/todobackend/ssl/account.json
  echo ${SERVICE_ACCOUNT} > /home/circleci/todobackend/ssl/account.json
}

setup_ssl_files() {
  if gcloud auth activate-service-account --key-file=/home/circleci/todobackend/ssl/account.json; then
    gsutil cp gs://${GCLOUD_TODO_BUCKET}/ssl/andela_certificate.crt /home/circleci/todobackend/ssl/andela_certificate.crt
    gsutil cp gs://${GCLOUD_TODO_BUCKET}/ssl/andela_key.key /home/circleci/todobackend/ssl/andela_key.key
  fi
}

initialise_terraform() {
  echo "Initializing terraform"

  pushd /home/circleci/todobackend/terraform
    export TF_VAR_state_path="terraform/state/terraform.tfstate"
    export TF_VAR_project=${GCLOUD_TODO_PROJECT}
    export TF_VAR_bucket=${GCLOUD_TODO_BUCKET}

    terraform init -backend-config="path=${TF_VAR_state_path}" -backend-config="project=${TF_VAR_project}" -backend-config="bucket=${TF_VAR_bucket}" -var="todo_disk_image=${PACKER_TAG}"
  popd
}

build_infrastructure() {
  echo "Building todobackend infrastructure and deploying todobackend application"

  pushd /home/circleci/todobackend/terraform
    touch terraform_output.log
    terraform apply --parallelism=1 -var="todo_state_path=${TF_VAR_state_path}" -var="todo_project_id=${TF_VAR_project}" -var="todo_bucket=${TF_VAR_bucket}" -var="todo_disk_image=${PACKER_TAG}" \
    2>&1 | tee terraform_output.log
    
  popd
}

main() {
  echo "Deploying application infrastructure"

  create_service_account
  setup_ssl_files
  initialise_terraform
  build_infrastructure
}

main "$@"