# Powerlevel10k Instant Prompt (should be at the top)
# This section initializes Powerlevel10k's instant prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh settings
export ZSH="$HOME/.oh-my-zsh"  # Path to your oh-my-zsh installation.

# Set the theme for Oh My Zsh
ZSH_THEME="robbyrussell"  # Change theme name if you prefer a different theme.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )  # Uncomment for random theme selection

# Enable case-sensitive completion
# CASE_SENSITIVE="true"  # Uncomment to enable case-sensitive completion

# Set auto-update mode for Oh My Zsh
zstyle ':omz:update' mode auto  # Automatically updates without asking

# Set update frequency (in days)
# zstyle ':omz:update' frequency 13  # Uncomment to change update frequency

# List of plugins to load
plugins=(
  git
  dirhistory
  history
  colored-man-pages
  jsontools
  zsh-autocomplete
  zsh-autosuggestions
  zsh-syntax-highlighting
  fzf-zsh-plugin
)

# Initialize Oh My Zsh
source $ZSH/oh-my-zsh.sh

# User configuration

# Uncomment to set your preferred editor for local and remote sessions
# export EDITOR="vim"

# Compilation flags for specific architecture (if needed)
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases here
# Example aliases:
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Enable/Disable various behaviors
DISABLE_LS_COLORS="false"  # Set to "true" to disable color in 'ls'
DISABLE_AUTO_TITLE="true"  # Disable auto-setting of terminal title
ENABLE_CORRECTION="true"   # Enable command auto-correction

# Enable/disable command waiting dots (dots show while waiting for completion)
COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"

# Set environment variables or paths if needed
# export PATH=$HOME/bin:/usr/local/bin:$PATH  # Uncomment if needed

# Set the language environment if needed
# export LANG=en_US.UTF-8
