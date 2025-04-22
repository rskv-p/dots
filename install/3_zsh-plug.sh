#!/bin/bash

# Function to print information messages with green color
function echo_info() {
    echo -e "\033[1;32m$1\033[0m"
}

# Install Powerlevel10k theme for Zsh
echo_info "Installing Powerlevel10k..."
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
else
    echo_info "Powerlevel10k is already installed."
fi

# Install plugins for Zsh
echo_info "Installing Zsh plugins..."

# Plugins for autocomplete and syntax highlighting
for plugin in zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search; do
    if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/$plugin" ]; then
        git clone https://github.com/zsh-users/$plugin ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/$plugin
    else
        echo_info "$plugin is already installed."
    fi
done

# Add plugins to .zshrc configuration
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search)/' ~/.zshrc

# Install Sarasa Mono TC Nerd Font
echo_info "Installing Sarasa Mono TC Nerd Font..."
FONT_DIR="${HOME}/.local/share/fonts"
mkdir -p $FONT_DIR

# Download font from the source
FONT_ZIP="${FONT_DIR}/SarasaMono.zip"
curl -L -o "$FONT_ZIP" "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/SarasaMono.zip"

# Verify if the font archive was downloaded correctly
if [ -f "$FONT_ZIP" ]; then
    unzip -o "$FONT_ZIP" -d $FONT_DIR
else
    echo_info "Error downloading the font. Please try again."
    exit 1
fi

# Update font cache
fc-cache -r

# Configure Zsh with Powerlevel10k theme
echo_info "Configuring Zsh with Powerlevel10k..."
sed -i 's|ZSH_THEME=".*"|ZSH_THEME="powerlevel10k/powerlevel10k"|' ~/.zshrc

# Reload Zsh configuration
source ~/.zshrc

echo_info "Zsh is configured and ready to use! Please restart the terminal."
