#!/bin/bash

# Function to print information messages in green
function echo_info() {
    echo -e "\033[1;32m$1\033[0m"
}

# Function to print error messages in red
function echo_error() {
    echo -e "\033[1;31m$1\033[0m"
}

# Function to check if Homebrew is installed
check_brew_installed() {
    if command -v brew &>/dev/null; then
        echo_info "Homebrew is already installed."
        return 0
    else
        return 1
    fi
}

# Function to install Homebrew on Linux
install_brew() {
    if check_brew_installed; then
        echo_info "Homebrew is already installed. Skipping installation."
        return
    fi

    echo_info "Installing Homebrew for Linux..."

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    echo_info "Adding Homebrew to your PATH..."
    (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/$(whoami)/.zshrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

    echo_info "Installing Homebrew's dependencies..."
    sudo apt-get update
    sudo apt-get install build-essential -y
}

# Function to install GCC using Homebrew
install_gcc() {
    echo_info "Installing GCC via Homebrew..."
    brew install gcc
}

# Run the install function
install_brew

# If Homebrew is installed, install GCC
if check_brew_installed; then
    install_gcc
else
    echo_error "There was an issue with installing Homebrew."
    exit 1
fi

echo_info "Homebrew was successfully installed!"
brew --version
