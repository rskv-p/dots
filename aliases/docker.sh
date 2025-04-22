# Common command aliases for Linux/macOS

alias c='clear'                       # Clear the terminal
alias echopath='echo $PATH | tr ":" "\n"'  # Print PATH line by line
alias edit-last-command-in-editor='fc'  # Edit the last command in the default editor
alias h='history | less'               # View history with paging
alias l='ls -lhF'                      # List files with human-readable sizes
alias la='ls -AlhF'                    # List all files with human-readable sizes
alias ll='ls -alhF'                    # List detailed files with human-readable sizes
alias m='make'                         # Run make
alias now='date +"%Y-%m-%d %H:%M:%S"'   # Print current date and time
alias p8='ping 8.8.8.8'                # Ping Google DNS
alias p='ping'                          # General ping command
alias psssh='ps aux | grep ssh'         # Search for running ssh processes
alias t.='tree .'                      # Display directory tree

# File manager
alias e.='xdg-open .'                  # Open current directory with file manager
alias o.='xdg-open .'                  # Open current directory with file manager

# Make directory and touch a file
touchp () {
  mkdir -p $(dirname "$1") && touch "$1"  # Create parent directories and touch a file
}
