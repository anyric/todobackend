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
  sudo apt-get install -y git docker-ce build-essential
  apt-cache policy docker-engine
  sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose

  sudo usermod -aG docker $USER
  sudo systemctl enable docker
  sudo systemctl restart docker
}

setup_application() {
  git clone -b master https://github.com/anyric/todobackend.git
  cd /home/todo/todobackend
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
