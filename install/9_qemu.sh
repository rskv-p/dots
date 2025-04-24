#!/bin/bash

# Function to print information messages in green
function echo_info() {
    echo -e "\033[1;32m$1\033[0m"
}

# Function to print error messages in red
function echo_error() {
    echo -e "\033[1;31m$1\033[0m"
}

# Function to check if the processor supports virtualization
check_virtualization_support() {
    echo_info "Checking CPU virtualization support..."
    if ! egrep -c '(vmx|svm)' /proc/cpuinfo; then
        echo_error "Your processor does not support virtualization. Installation aborted."
        exit 1
    fi
}

# Function to install KVM and QEMU
install_kvm_and_qemu() {
    echo_info "Installing KVM and QEMU..."

    # Update package index and install dependencies
    sudo apt update
    sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager

    echo_info "KVM and QEMU installation complete."
}

# Function to add the user to the libvirt group for managing virtual machines without sudo
add_user_to_libvirt_group() {
    echo_info "Adding user to the libvirt group..."
    sudo usermod -aG libvirt $USER
    echo_info "User added to the libvirt group. Please log out and log back in to apply changes."
}

# Function to install Virt-Manager
install_virt_manager() {
    echo_info "Installing Virt-Manager for graphical interface management..."

    # Install Virt-Manager
    sudo apt install -y virt-manager

    # Verify the installation
    if type "virt-manager" &>/dev/null; then
        echo_info "Virt-Manager installed successfully."
    else
        echo_error "Failed to install Virt-Manager."
        exit 1
    fi
}

# Main installation function
install_kvm_and_virt_manager() {
    # Check if virtualization is supported
    check_virtualization_support

    # Install KVM and QEMU
    install_kvm_and_qemu

    # Add the user to the libvirt group
    add_user_to_libvirt_group

    # Install Virt-Manager
    install_virt_manager

    # Final message
    echo_info "KVM, QEMU, and Virt-Manager have been successfully installed."
    echo_info "You can now create and manage virtual machines using Virt-Manager or virsh commands."
}

# Run the main installation function
install_kvm_and_virt_manager
