#!/bin/bash

# Function to print information messages in green
function echo_info() {
    echo -e "\033[1;32m$1\033[0m"
}

# Function to print error messages in red
function echo_error() {
    echo -e "\033[1;31m$1\033[0m"
}

# Declare an associative array for package managers and their install commands
declare -A package_managers=(
  ["apt-get"]="sudo apt install -y"
  ["brew"]="brew install"
)

# Function to install a package using an available package manager
install_package() {
  local package=$1
  for manager in "${!package_managers[@]}"; do
    # Check if the package manager is available
    if type "$manager" &> /dev/null; then
      ${package_managers[$manager]} "$package"
      return 0
    fi
  done
  # Print error message if no suitable package manager is found
  echo_error "$package: Failed to find a suitable package manager."
}

# Check and install required programs
for package in git curl unzip; do
  # If the package is not already installed, install it
  if ! type "$package" &> /dev/null; then
    echo_info "Installing $package..."
    install_package "$package"
  else
    echo_info "$package is already installed."
  fi
done
