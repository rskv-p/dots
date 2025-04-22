#!/bin/bash

GIT_NAME=${GIT_NAME:-"rskv-p"}
GIT_MAIL=${GIT_MAIL:-"malius@tutamail.com.com"}

log() {
  # Custom log function for better logging with timestamp
  echo "[$(date +"%Y-%m-%d %H:%M:%S")] $1"
}

check_command() {
  # Check if a command exists
  command -v "$1" >/dev/null 2>&1 || { log "Error: $1 is not installed. Exiting..."; exit 1; }
}

install() {
  log "Starting installation of scripts..."

  for INSTALL_SCRIPT in ~/dots/scripts/install/*.sh; do
    if [ -f "$INSTALL_SCRIPT" ]; then
      log "Running $INSTALL_SCRIPT..."
      bash ${INSTALL_SCRIPT} || { log "Failed to run $INSTALL_SCRIPT"; exit 1; }
    else
      log "Install script $INSTALL_SCRIPT not found!"
    fi
  done

  log "Installation of scripts completed."
}

backup() {
  if [ -f ${1} ]; then
    mkdir -p $(dirname ${1})
    TIMESTAMP=$(date +"%Y-%m-%d,%H:%M:%S")
    log "Backing up ${1} to ${1}.backup.${TIMESTAMP}"
    mv ${1} ${1}.backup.${TIMESTAMP}
  fi
}

setup_zsh() {
  log "Setting up Zsh..."

  # Check if files already exist before creating symlinks
  backup $HOME/.zshenv
  backup $HOME/.zlogin
  backup $HOME/.zimrc

  ln -s $HOME/dots/zsh/zim/zshenv.zsh $HOME/.zshenv
  ln -s $HOME/dots/zsh/zim/zlogin.zsh $HOME/.zlogin
  ln -s $HOME/dots/zsh/zim/zimrc.zsh $HOME/.zimrc
  echo "source $HOME/dots/zsh/zim/zshrc.zsh" > $HOME/.zshrc

  # Ensure local configuration files exist
  mkdir -p ~/dots/local
  touch ~/dots/local/local.zsh
  touch ~/dots/local/theme.zsh

  log "Installing Zsh modules..."
  zsh ~/.zim/zimfw.zsh install || { log "Failed to install Zsh modules"; exit 1; }

  zsh -c "echo 'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true' >>! ~/.zshrc"

  log "Zsh setup completed!"
}

setup_git() {
  log "Setting up Git..."

  # Ensure git is available
  check_command "git"

  git config --global user.name ${GIT_NAME}
  git config --global user.email ${GIT_MAIL}
  git config --global pull.rebase true
  git config --global core.editor code
  git config --global core.ignoreCase false
  git config --global init.defaultBranch main

  log "Git setup completed!"
}

setup_fnm_completions_for_linux() {
  if [ "$(uname)" = "Linux" ]; then
    export PATH="$HOME/.local/share/fnm:$PATH"
    eval "$(fnm env)"

    rm -f ~/dots/zsh/completions/_fnm
    fnm completions --shell zsh > ~/dots/zsh/completions/_fnm
    log "FNM completions set up for Linux"
  fi
}

# Check required commands before starting installation
check_command "git"
check_command "zsh"

# Run the installation process
install
setup_zsh
setup_git
setup_fnm_completions_for_linux

log "🎉 All Done!"
log "🙌 Some changes might need re-login to take effect."
