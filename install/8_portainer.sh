#!/bin/bash

# Function to print information messages in green
function echo_info() {
    echo -e "\033[1;32m$1\033[0m"
}

# Function to print error messages in red
function echo_error() {
    echo -e "\033[1;31m$1\033[0m"
}

# Function to check if Docker is already installed
check_docker_installed() {
    if type "docker" &>/dev/null; then
        echo_info "Docker is already installed."
        return 0
    else
        return 1
    fi
}

# Function to install Docker
install_docker() {
    echo_info "Installing Docker..."

    # Update package index and install dependencies for Docker installation
    sudo apt update
    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

    # Add Docker’s official GPG key and install Docker
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh

    # Add the current user to the Docker group to avoid using 'sudo' with Docker commands
    sudo usermod -aG docker $USER

    echo_info "Docker has been successfully installed."
}

# Function to install Portainer
install_portainer() {
    echo_info "Installing Portainer..."

    # Create a Docker volume for Portainer data
    sudo docker volume create portainer_data

    # Run Portainer container
    sudo docker run -d -p 9000:9000 -p 9443:9443 \
        --name portainer \
        --restart always \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v portainer_data:/data \
        portainer/portainer-ce:latest

    echo_info "Portainer has been installed and is running."
    echo_info "Access Portainer at http://localhost:9000 or https://localhost:9443."
}

# Main function to install Docker and Portainer
main() {
    # Check if Docker is installed
    if ! check_docker_installed; then
        install_docker
    else
        echo_info "Skipping Docker installation as it's already installed."
    fi

    # Install Portainer
    install_portainer
}

# Run the main function
main
