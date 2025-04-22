# Dots

This repository contains various configurations and installation scripts for setting up a development environment. It includes configurations for **Zsh**, **Node.js**, **Go**, **Portainer**, **QEMU**, **Vscode**, and many other development tools and utilities.

## Directory Structure

Here is an overview of the project structure:

```
.
├── alacritty
│   └── alacritty.yml         # Configuration for Alacritty terminal
├── aliases
│   ├── apt.sh                # Apt-related aliases for easy package management
│   ├── brew.sh               # Homebrew-related aliases
│   ├── bun.sh                # Bun package manager-related aliases
│   ├── common.sh             # Common aliases
│   ├── directory.sh          # Directory management aliases
│   ├── docker.sh             # Docker-related aliases
│   ├── git.sh                # Git-related aliases
│   ├── go.sh                 # Go-related aliases
│   └── vscode.sh             # VSCode-related aliases
├── bootstrap.sh              # Bootstrap script for setting up the environment
├── install
│   ├── 0_requirements.sh     # Installation script for dependencies
│   ├── 10_qemu.sh            # Installation script for QEMU (virtualization)
│   ├── 1_zsh.sh              # Installation script for Zsh
│   ├── 3_zsh-plug.sh         # Installation script for Zsh plugins
│   ├── 4_node.sh             # Installation script for Node.js
│   ├── 6_node_mng.sh         # Node version manager setup script
│   ├── 7_go.sh               # Installation script for Go
│   ├── 8_ai.sh               # AI tools installation script
│   └── 9_portainer.sh        # Portainer installation script
├── LICENSE                   # License file for the project
├── package.json              # Project's package.json for NPM dependencies (if any)
├── README.md                 # Project's README file
└── vscode
    ├── package.json          # VSCode project-specific extensions/settings
    ├── settings
    │   ├── keybindings.json  # Custom VSCode keybindings
    │   └── settings.json     # Custom VSCode settings
    └── snippets
        └── go.json           # Go language snippets for VSCode
```

## Key Features

- **Terminal Configurations**:
  - `alacritty/alacritty.yml`: Configures the Alacritty terminal for optimal performance.
  - `aliases/*`: Various helpful shell aliases to speed up common tasks (e.g., Docker, Git, Go).
  
- **Development Tools**:
  - `install/0_requirements.sh`: Installs required dependencies.
  - `install/1_zsh.sh`: Installs Zsh shell if not already installed.
  - `install/4_node.sh`: Installs Node.js using a version manager.
  - `install/7_go.sh`: Installs Go programming language and sets up the environment.
  - `install/9_portainer.sh`: Installs Portainer, a Docker management tool.
  
- **VSCode Configuration**:
  - `vscode/settings/settings.json`: VSCode settings for customizing the editor.
  - `vscode/snippets/go.json`: Custom Go language snippets for use within VSCode.

## Setup

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/projectname.git
   cd projectname
   ```

2. **Run the `bootstrap.sh` Script**:
   The `bootstrap.sh` script will handle the environment setup, installing necessary dependencies and configurations.
   ```bash
   ./bootstrap.sh
   ```

3. **Optional**: To install specific tools or configure additional settings, you can run individual installation scripts from the `install/` folder.

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.
