#!/bin/bash

# Установка Docker (если не установлен)
if ! type "docker" &>/dev/null; then
  echo "Устанавливаю Docker..."
  
  sudo apt update
  sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  sudo usermod -aG docker $USER
  echo "Docker установлен."
else
  echo "Docker уже установлен."
fi

# Установка Portainer
echo "Устанавливаю Portainer..."

# Создаем том для Portainer
sudo docker volume create portainer_data

# Запуск контейнера Portainer
sudo docker run -d -p 9000:9000 -p 9443:9443 \
  --name portainer \
  --restart always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  portainer/portainer-ce:latest

echo "Portainer установлен и запущен. Доступ через http://localhost:9000 или https://localhost:9443."
