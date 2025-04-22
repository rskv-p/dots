#!/bin/bash

# Array for package managers and their install commands
declare -A package_managers=(
  ["pkg"]="pkg install -y"
  ["apt-get"]="sudo apt install -y"
  ["brew"]="brew install"
  ["apk"]="apk add"
  ["pacman"]="yes | sudo pacman -S"
)

# Function to install a package
install_package() {
  local package=$1
  for manager in "${!package_managers[@]}"; do
    # Check if the package manager is available
    if type "$manager" &> /dev/null; then
      echo "Using $manager to install $package..."
      ${package_managers[$manager]} "$package"
      return 0
    fi
  done
  # Print error message if no suitable package manager is found
  echo "$package: Failed to find a suitable package manager."
  return 1
}

# Check if Zsh is already installed
if type zsh &> /dev/null; then
  echo 'Zsh is already installed, skipping installation.'
else
  echo 'Installing Zsh...'

  # Try installing Zsh
  if ! install_package "zsh"; then
    echo 'Failed to install Zsh. Please check your package manager and try again.'
    exit 1
  fi
fi

# Ask if user wants to change the default shell to Zsh
read -p 'Change default login shell to Zsh? [y/N]: ' answer
case $answer in
  [Yy]* ) chsh -s "$(which zsh)";;
  * ) ;;
esac

echo 'Zsh installation complete and ready to use!'
