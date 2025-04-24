# Common command aliases for Linux/macOS

# Clear the terminal
alias c='clear'

# Print PATH line by line
alias echopath='echo $PATH | tr ":" "\n"'

# Edit the last command in the default editor
alias edit-last-command-in-editor='fc'

# View history with paging
alias h='history | less'

# List files with human-readable sizes
alias l='ls -lhF'

# List all files with human-readable sizes
alias la='ls -AlhF'

# List detailed files with human-readable sizes
alias ll='ls -alhF'

# Run make
alias m='make'

# Print current date and time
alias now='date +"%Y-%m-%d %H:%M:%S"'

# Ping Google DNS
alias p8='ping 8.8.8.8'

# General ping command
alias p='ping'

# Search for running ssh processes
alias psssh='ps aux | grep ssh'

# Display directory tree
alias t.='tree .'

# File manager - Open current directory with file manager
alias e.='xdg-open .'
alias o.='xdg-open .'

# Make directory and touch a file (create parent directories if needed)
touchp () {
  mkdir -p $(dirname "$1") && touch "$1"
}

# Install utilities and create aliases for them (from lsd, bpytop, bat, fzf, stow)
# lsd - Enhanced ls with icons and colors
alias lsd='lsd'

# bpytop - Python-based system resource monitor
alias bpytop='bpytop'

# bat - A cat clone with syntax highlighting and Git integration
alias bat='batcat'

# fzf - Command-line fuzzy finder
alias fzf='fzf'

# stow - Symlink manager for dotfiles
alias stow='stow'
