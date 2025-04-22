#!/bin/bash

# Function to print information messages in green
function echo_info() {
    echo -e "\033[1;32m$1\033[0m"
}

# Check if Go is already installed
if type go &> /dev/null; then
    echo_info "Go is already installed, skipping installation."
    exit 0
fi

# Determine the platform and architecture
OS=$(uname -s)
ARCH=$(uname -m)

# Set Go download URL based on platform and architecture
GO_VERSION="1.20.5"  # Specify the desired Go version
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
echo_info "Downloading Go..."
curl -LO "$GO_URL"
tar -C /usr/local -xzf "go$GO_VERSION.linux-amd64.tar.gz"

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
echo_info "Go has been successfully installed and set up!"
go
