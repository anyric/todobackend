#!/bin/bash

set -ex
set -o pipefail

create_service_account() {
  touch /home/circleci/todobackend/account.json
  echo ${SERVICE_ACCOUNT} > /home/circleci/todobackend/account.json
}

build_packer_image() {
  echo "Rebuilding the packer image"

  pushd  /home/circleci/todobackend/packer
    touch packer_output.log
    HOME_PATH=" /home/circleci/todobackend/" PROJECT_ID="$GCLOUD_TODO_PROJECT" packer build packer.json 2>&1 | tee packer_output.log
    PACKER_TAG="$(grep 'A disk image was created:' packer_output.log | cut -d' ' -f8)"
  popd
  mkdir -p workspace
  echo $PACKER_TAG > ~/todobackend/workspace/output
  cat ~/todobackend/workspace/output
}

main() {
  create_service_account
  build_packer_image
}

main "@$"