#!/bin/bash

# Function to print information messages in green
function echo_info() {
    echo -e "\033[1;32m$1\033[0m"
}

# Install NVIDIA drivers
echo_info "Checking if NVIDIA driver is installed..."
if ! type nvidia-smi &> /dev/null; then
    echo_info "NVIDIA driver is not installed. Installing the driver..."

    # Check package manager and install the driver
    if type apt-get &> /dev/null; then
        # Ubuntu / Debian
        sudo apt update
        sudo apt install -y nvidia-driver nvidia-cuda-toolkit
    elif type pacman &> /dev/null; then
        # Arch Linux / Manjaro
        sudo pacman -Syu --noconfirm nvidia nvidia-utils
    elif type dnf &> /dev/null; then
        # Fedora
        sudo dnf install -y akmod-nvidia nvidia-driver
    else
        echo_info "Driver installation is not supported for this OS."
        exit 1
    fi

    # Reboot system to apply changes
    echo_info "NVIDIA driver installed. A reboot is required to apply changes."
    read -p "Reboot now? [y/N]: " answer
    if [[ "$answer" =~ ^[Yy]$ ]]; then
        sudo reboot
    fi
else
    echo_info "NVIDIA driver is already installed."
fi

# Install CUDA
echo_info "Checking if CUDA is installed..."
if ! type nvcc &> /dev/null; then
    echo_info "CUDA is not installed. Installing CUDA..."

    # Install CUDA
    if type apt-get &> /dev/null; then
        # Ubuntu / Debian
        sudo apt update
        sudo apt install -y nvidia-cuda-toolkit
    elif type pacman &> /dev/null; then
        # Arch Linux / Manjaro
        sudo pacman -Syu --noconfirm cuda
    elif type dnf &> /dev/null; then
        # Fedora
        sudo dnf install -y cuda
    else
        echo_info "CUDA installation is not supported for this OS."
        exit 1
    fi

    # Reboot system to apply changes
    echo_info "CUDA installed. A reboot is required to apply changes."
    read -p "Reboot now? [y/N]: " answer
    if [[ "$answer" =~ ^[Yy]$ ]]; then
        sudo reboot
    fi
else
    echo_info "CUDA is already installed."
fi

# Set environment variables for CUDA
echo_info "Setting up environment variables for CUDA..."
echo 'export PATH=/usr/local/cuda/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc

# Apply changes to the current session
source ~/.bashrc

# Verify the installation
echo_info "Verifying NVIDIA and CUDA installation..."

# Check NVIDIA driver
nvidia-smi

# Check CUDA
nvcc --version

echo_info "NVIDIA and CUDA installation complete!"
