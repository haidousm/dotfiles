#!/bin/bash

# Enable strict mode
set -euo pipefail
IFS=$'\n\t'

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if GNU Stow is installed
if ! command_exists stow; then
    echo "GNU Stow is not installed."

    # Check if Homebrew is installed
    if ! command_exists brew; then
        echo "Error: Homebrew is not installed. Please install Homebrew first."
        exit 1
    fi

    # Install GNU Stow using Homebrew
    echo "Installing GNU Stow using Homebrew..."
    brew install stow

    # Verify installation
    if ! command_exists stow; then
        echo "Error: GNU Stow installation failed."
        exit 1
    fi
fi

# Stow the current directory
echo "Stowing the current directory..."
stow .

