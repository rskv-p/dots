#!/bin/bash

# Function to print information messages in green
function echo_info() {
    echo -e "\033[1;32m$1\033[0m"
}

# Function to print error messages in red
function echo_error() {
    echo -e "\033[1;31m$1\033[0m"
}

# Function to check if Oh My Zsh is installed
check_oh_my_zsh_installed() {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo_error "Oh My Zsh is required for Powerlevel10k theme. Please install Oh My Zsh first."
        exit 1
    fi
}

# Function to install Powerlevel10k
install_powerlevel10k() {
    check_oh_my_zsh_installed

    echo_info "Installing Powerlevel10k theme..."

    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

    sed -i 's|ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' ~/.zshrc

    echo '# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.' >>~/.zshrc
    echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >>~/.zshrc

    echo_info "Copying .p10k.zsh from zsh/.p10k.zsh to the home directory..."
    cp ./zsh/.p10k.zsh ~/.p10k.zsh
}

# Function to check if the required font 'FiraCode' is installed
check_font() {
    if ask_yes_no "Is the font 'FiraCode' installed in your terminal?"; then
        echo_info "Powerlevel10k has been successfully installed. Restart your terminal to see the changes."
        echo_info "To customize your prompt, run: p10k configure."
    else
        echo_error "Please install the font 'FiraCode' in your terminal, then reinstall Powerlevel10k."
        echo_info "You can get the font from: https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip"
    fi
}

# Run the installation function
install_powerlevel10k

# Check font installation
check_font
