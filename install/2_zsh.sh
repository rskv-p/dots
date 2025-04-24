#!/bin/bash

# Function to print information messages in green
function echo_info() {
    echo -e "\033[1;32m$1\033[0m"
}

# Function to print error messages in red
function echo_error() {
    echo -e "\033[1;31m$1\033[0m"
}

# Function to install Zsh if it's not already installed
install_zsh() {
  if type zsh >/dev/null 2>&1; then
    echo_info "Zsh is already installed. Skipping installation."
    return
  fi

  echo_info "Installing Zsh..."
  sudo apt install zsh -y

  echo_info "Checking Zsh version..."
  zsh --version

  echo_info "Setting Zsh as default shell..."
  chsh -s $(which zsh)
  echo_info "Current shell: $SHELL"
  $SHELL --version
}

# Function to install Oh My Zsh and essential plugins
install_oh_my_zsh_and_utilities() {
  echo_info "Installing Oh My Zsh..."

  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
  else
    echo_info "Oh My Zsh is already installed."
  fi

  echo_info "Installing Zsh plugins..."
  git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete
  git clone --depth 1 https://github.com/unixorn/fzf-zsh-plugin.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-zsh-plugin

  echo_info "Updating .zshrc configuration..."
  cp ./zsh/.zshrc ~/.zshrc

  # Automatically set Zsh as default shell if not already done
  chsh -s $(which zsh)
  
  echo_info "Installing utilities..."

  # Automatically install utilities and their aliases
  sudo snap install lsd
  sudo snap install bpytop
  sudo apt install bat stow -y

  # Add aliases to .zshrc from root.sh
  echo 'source "$HOME/dots/aliases/root.sh"' >> ~/.zshrc

  echo_info "Installation completed!"
  zsh
}

# Run the installation functions
install_zsh
install_oh_my_zsh_and_utilities
