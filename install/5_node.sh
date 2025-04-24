#!/bin/bash

# Function to print information messages in green
function echo_info() {
    echo -e "\033[1;32m$1\033[0m"
}

# Function to install n (Node.js version manager) using Homebrew
install_n() {
    echo_info "Installing 'n' (Node.js version manager) using Homebrew..."
    brew install n
}

# Function to fix folder access for n
fix_n_folder_access() {
    echo_info "Fixing folder access for 'n'..."

    sudo mkdir -p /usr/local/n
    sudo chown -R $(whoami) /usr/local/n
    sudo mkdir -p /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share
    sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share
}

# Function to install pnpm (a package manager for Node.js)
install_pnpm() {
    echo_info "Installing 'pnpm' using Homebrew..."
    brew install pnpm
}

# Function to install yarn (another popular package manager for Node.js)
install_yarn() {
    echo_info "Installing 'yarn' using Homebrew..."
    brew install yarn
}

# Function to install unzip
install_unzip() {
    echo_info "Installing 'unzip'..."
    sudo apt install unzip -y
}

# Function to install bun (a fast JavaScript bundler and task runner)
install_bun() {
    echo_info "Installing 'bun'..."
    curl -fsSL https://bun.sh/install | bash
}

# Function to install a specific version of Node.js using n
install_node() {
    NODE_VERSION="22"
    echo_info "Installing Node.js version $NODE_VERSION using 'n'..."
    n $NODE_VERSION
}

# Run all the installation functions in order
install_n
fix_n_folder_access
install_pnpm
install_yarn
install_unzip
install_bun
install_node

echo_info "Installation of 'n', Node.js, and related tools is complete!"
