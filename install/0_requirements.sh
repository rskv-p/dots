# Array for package managers and their install commands
declare -A package_managers=(
  ["pkg"]="pkg install -y"
  ["apt-get"]="sudo apt install -y"
  ["brew"]="brew install"
  ["apk"]="apk add"
  ["pacman"]="yes | sudo pacman -S"
)

# Function to install a package
install_package() {
  local package=$1
  for manager in "${!package_managers[@]}"; do
    # Check if the package manager is available
    if type "$manager" &> /dev/null; then
      ${package_managers[$manager]} "$package"
      return 0
    fi
  done
  # Print error message if no suitable package manager is found
  echo "$package: Failed to find a suitable package manager."
}

# Check and install programs
for package in git curl unzip; do
  # If the package is not found, install it
  if ! type "$package" &> /dev/null; then
    install_package "$package"
  fi
done
