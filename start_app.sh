#!/bin/bash

configure_nginx(){
  sudo systemctl start nginx
  sudo cp /home/todo/todobackend/todo.conf /etc/nginx/sites-available/todo.conf
  sudo rm -rf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
  sudo ln -s /etc/nginx/sites-available/todo.conf /etc/nginx/sites-enabled/
  sudo ufw allow 'Nginx Full'
  sudo systemctl restart nginx
}

start_app() {
  cd /home/todo/todobackend
  sudo make test
  sudo make build
  sudo make release
}

main(){
  configure_nginx
  start_app
}

main "$@"