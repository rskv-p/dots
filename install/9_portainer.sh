#!/bin/bash

# Install Docker if it's not already installed
if ! type "docker" &>/dev/null; then
  echo "Installing Docker..."
  
  # Update package index and install dependencies for Docker installation
  sudo apt update
  sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

  # Add Docker’s official GPG key and install Docker
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh

  # Add the current user to the Docker group to avoid using 'sudo' with Docker commands
  sudo usermod -aG docker $USER
  
  echo "Docker has been successfully installed."
else
  echo "Docker is already installed."
fi

# Install Portainer
echo "Installing Portainer..."

# Create a Docker volume for Portainer data
sudo docker volume create portainer_data

# Run Portainer container
sudo docker run -d -p 9000:9000 -p 9443:9443 \
  --name portainer \
  --restart always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  portainer/portainer-ce:latest

echo "Portainer has been installed and is running. Access it at http://localhost:9000 or https://localhost:9443."
