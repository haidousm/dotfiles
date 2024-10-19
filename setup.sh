#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

install_if_missing() {
    local cmd=$1
    local brew_pkg=$2
    if ! command_exists "$cmd"; then
        echo "$cmd is not installed."

        if ! command_exists brew; then
            echo "Error: Homebrew is not installed. Please install Homebrew first."
            exit 1
        fi

        echo "Installing $cmd using Homebrew..."
        brew install "$brew_pkg"

        if ! command_exists "$cmd"; then
            echo "Error: $cmd installation failed."
            exit 1
        fi
    fi
}

install_if_missing_with_prompt() {
    local cmd=$1
    local brew_pkg=$2
    if ! command_exists "$cmd"; then
        echo "$cmd is not installed."

        if ! command_exists brew; then
            echo "Error: Homebrew is not installed. Please install Homebrew first."
            exit 1
        fi

        read -p "Do you want to install $cmd using Homebrew? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            install_if_missing "$cmd" "$brew_pkg"
        else
            echo "Skipping installation of $cmd."
        fi
    fi
}

install_if_missing stow stow
install_if_missing zsh zsh
install_if_missing git git
install_if_missing tmux tmux
install_if_missing nvim neovim
install_if_missing go go
install_if_missing fzf fzf
install_if_missing zoxide zoxide
install_if_missing tms tmux-sessionizer

install_if_missing_with_prompt kubectl kubectl

if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    echo "Installing powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    echo "Installing zsh-autosuggestions plugin..."
    git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi

if [ ! -d "/opt/homebrew/share/zsh-syntax-highlighting" ]; then
    echo "Installing zsh-syntax-highlighting plugin..."
    brew install zsh-syntax-highlighting
fi

echo "Stowing the current directory..."
stow .
