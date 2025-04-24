#!/bin/bash

# Function to print information messages in green
function echo_info() {
    echo -e "\033[1;32m$1\033[0m"
}

# Function to print error messages in red
function echo_error() {
    echo -e "\033[1;31m$1\033[0m"
}

# Function to check if the NVIDIA driver is already installed
check_nvidia_installed() {
    if nvidia-smi >/dev/null 2>&1; then
        echo_info "NVIDIA driver is already installed."
        echo_info "GPU Information:"
        nvidia-smi --query-gpu=name --format=csv,noheader
        nvidia-smi
        return 0
    else
        return 1
    fi
}

# Function to install the NVIDIA driver on Linux
install_nvidia_driver_linux() {
    echo_info "Installing NVIDIA driver on Linux..."

    if check_nvidia_installed; then
        return
    fi

    echo_info "Downloading the NVIDIA driver..."
    wget https://fr.download.nvidia.com/XFree86/Linux-x86_64/535.129.03/NVIDIA-Linux-x86_64-535.129.03.run

    chmod +x NVIDIA-Linux-x86_64-535.129.03.run

    echo_info "Installing GCC and dependencies..."
    sudo apt install build-essential -y

    echo_info "Running the NVIDIA driver installer..."
    sudo ./NVIDIA-Linux-x86_64-535.129.03.run

    rm NVIDIA-Linux-x86_64-535.129.03.run

    echo_info "NVIDIA driver installed successfully."

    echo_info "GPU Information:"
    nvidia-smi --query-gpu=name --format=csv,noheader
    nvidia-smi
}

# Function to handle macOS (No NVIDIA driver can be installed on macOS)
install_nvidia_driver_mac() {
    echo_error "No NVIDIA driver can be installed on macOS."
    exit 1
}

# Main function to detect the operating system and install the appropriate NVIDIA driver
install_nvidia_driver() {
    OS=$(uname)

    if [ "$OS" == "Linux" ]; then
        install_nvidia_driver_linux
    elif [ "$OS" == "Darwin" ]; then
        install_nvidia_driver_mac
    else
        echo_error "Unsupported operating system: $OS"
        exit 1
    fi
}

install_nvidia_driver
