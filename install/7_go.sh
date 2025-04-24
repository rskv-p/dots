#!/bin/bash

# Function to print information messages in green
function echo_info() {
    echo -e "\033[1;32m$1\033[0m"
}

# Function to compare Go versions
function compare_versions() {
    # Compare two versions: $1 is the current version, $2 is the version to install
    # Returns 0 if $1 >= $2, 1 if $1 < $2
    local ver1=$1
    local ver2=$2
    if [[ "$ver1" == "$ver2" ]]; then
        return 0
    fi

    if [[ "$ver1" == *"-"* ]]; then
        ver1=${ver1%-*}
    fi

    if [[ "$ver2" == *"-"* ]]; then
        ver2=${ver2%-*}
    fi

    local ver1_parts=(${ver1//./ })
    local ver2_parts=(${ver2//./ })

    # Loop through each part of the version and compare
    for ((i = 0; i < ${#ver1_parts[@]}; i++)); do
        local v1_part=${ver1_parts[$i]:-0}  # Default to 0 if no part available
        local v2_part=${ver2_parts[$i]:-0}  # Default to 0 if no part available
        if [[ $v1_part -gt $v2_part ]]; then
            return 0  # version $1 is greater
        elif [[ $v1_part -lt $v2_part ]]; then
            return 1  # version $1 is smaller
        fi
    done
    return 0  # versions are equal
}

# Check if Go is already installed
if type go &> /dev/null; then
    CURRENT_GO_VERSION=$(go version | awk '{print $3}' | sed 's/go//')
    echo_info "Current Go version: $CURRENT_GO_VERSION"
else
    CURRENT_GO_VERSION="none"
fi

# Desired Go version
GO_VERSION="1.24.2"  # Specify the desired Go version
echo_info "Desired Go version: $GO_VERSION"

# Compare the versions and install if the desired version is newer
compare_versions "$CURRENT_GO_VERSION" "$GO_VERSION"
if [ $? -eq 0 ]; then
    echo_info "Go $GO_VERSION is already installed or newer. Skipping installation."
    exit 0
fi

# Determine the platform and architecture
OS=$(uname -s)
ARCH=$(uname -m)

# Set Go download URL based on platform and architecture
if [ "$OS" == "Linux" ]; then
    if [ "$ARCH" == "x86_64" ]; then
        GO_URL="https://golang.org/dl/go$GO_VERSION.linux-amd64.tar.gz"
    elif [ "$ARCH" == "arm64" ]; then
        GO_URL="https://golang.org/dl/go$GO_VERSION.linux-arm64.tar.gz"
    else
        echo_info "Support for $ARCH is not found."
        exit 1
    fi
elif [ "$OS" == "Darwin" ]; then
    GO_URL="https://golang.org/dl/go$GO_VERSION.darwin-amd64.tar.gz"
else
    echo_info "Support for your OS ($OS) is not found."
    exit 1
fi

# Download and extract Go
echo_info "Downloading Go $GO_VERSION..."
curl -LO "$GO_URL"
tar -C /usr/local -xzf "go$GO_VERSION.linux-amd64.tar.gz"

# Delete the downloaded .tar.gz file
echo_info "Deleting the downloaded Go tar.gz file..."
rm -f "go$GO_VERSION.linux-amd64.tar.gz"

# Set up environment variables
echo_info "Setting up environment variables..."
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
echo 'export GOPATH=$HOME/go' >> ~/.bashrc
echo 'export GOBIN=$GOPATH/bin' >> ~/.bashrc
source ~/.bashrc

# Verify Go installation
echo_info "Verifying Go installation..."
go version

# Notify the user about successful installation
echo_info "Go $GO_VERSION has been successfully installed and set up!"
