#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

if ! command_exists stow; then
    echo "GNU Stow is not installed."

    if ! command_exists brew; then
        echo "Error: Homebrew is not installed. Please install Homebrew first."
        exit 1
    fi

    echo "Installing GNU Stow using Homebrew..."
    brew install stow

    if ! command_exists stow; then
        echo "Error: GNU Stow installation failed."
        exit 1
    fi
fi

echo "Stowing the current directory..."
stow .

