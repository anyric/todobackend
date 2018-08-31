#!/bin/bash

set -e
set -o pipefail

create_activo_user() {
  if ! id -u todo; then
    sudo useradd -m -s /bin/bash todo
  fi
}

install_docker() {
  sudo apt-get update -y
  sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  sudo apt-get update -y
  sudo apt-get install -y git docker-ce
}

setup_application() {
  echo "This is were I am"
  pwd
  make test
  make build
  make release
}
main() {
  create_activo_user
  install_docker
  setup_application
}

main "$@"
