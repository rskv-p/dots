#!/bin/bash

# Function to print information messages in green
function echo_info() {
    echo -e "\033[1;32m$1\033[0m"
}

# Run all install scripts
install_scripts=(
  "install/0_requirements.sh"
  "install/1_fonts.sh"
  "install/2_zsh.sh"
  "install/3_powerlevel10k.sh"
  "install/4_brew.sh"
  "install/5_node.sh"
  "install/6_nvidia.sh"
  "install/7_go.sh"
  "install/8_portainer.sh"
  "install/9_qemu.sh"
)

echo_info "Starting bootstrap installation..."

# Loop through all scripts and run them
for script in "${install_scripts[@]}"; do
  if [ -f "$script" ]; then
    echo_info "Running $script..."
    source "$script"
  else
    echo_error "Script $script not found!"
  fi
done

echo_info "Bootstrap installation completed!"
