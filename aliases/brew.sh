# Brew command aliases

if type brew &> /dev/null; then
  alias ud='brew update && brew outdated'  # Update brew and list outdated packages
  alias ug='brew upgrade'                 # Upgrade all outdated packages
  alias bcl='brew cleanup'                # Cleanup unused packages
fi
