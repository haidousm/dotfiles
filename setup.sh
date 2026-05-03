#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

OS="$(uname)"

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# ── macOS helpers ─────────────────────────────────────────────────────────────

brew_install_if_missing() {
    local cmd=$1
    local brew_pkg=$2
    if ! command_exists "$cmd"; then
        echo "Installing $cmd via Homebrew..."
        brew install "$brew_pkg"
    fi
}

brew_install_if_missing_with_prompt() {
    local cmd=$1
    local brew_pkg=$2
    if ! command_exists "$cmd"; then
        read -p "Install $cmd via Homebrew? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            brew install "$brew_pkg"
        else
            echo "Skipping $cmd."
        fi
    fi
}

setup_macos() {
    if ! command_exists brew; then
        echo "Error: Homebrew is not installed. Please install it first."
        exit 1
    fi

    brew_install_if_missing stow stow
    brew_install_if_missing zsh zsh
    brew_install_if_missing git git
    brew_install_if_missing tmux tmux
    brew_install_if_missing nvim neovim
    brew_install_if_missing go go
    brew_install_if_missing fzf fzf
    brew_install_if_missing zoxide zoxide
    brew_install_if_missing tms tmux-sessionizer

    brew_install_if_missing_with_prompt kubectl kubectl
}

# ── Linux helpers ─────────────────────────────────────────────────────────────

setup_linux() {
    echo "Installing system packages..."
    apt-get update -qq
    apt-get install -y git zsh curl wget stow tmux ripgrep fzf

    if ! command_exists zoxide; then
        echo "Installing zoxide..."
        curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    fi
}

# ── Common ────────────────────────────────────────────────────────────────────

setup_common() {
    # oh-my-zsh must come before plugins/themes
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "Installing oh-my-zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi

    if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
        echo "Installing powerlevel10k..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
            "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
    fi

    if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
        echo "Installing zsh-autosuggestions..."
        git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions \
            "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
    fi

    if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
        echo "Installing zsh-syntax-highlighting..."
        git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting \
            "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
    fi

    echo "Stowing dotfiles..."
    cd "$(dirname "$0")"
    stow --adopt .
    git checkout .

    if [ "$SHELL" != "$(which zsh)" ]; then
        echo "Setting zsh as default shell..."
        chsh -s "$(which zsh)"
    fi

    echo "Done. Open a new shell or run: exec zsh"
}

# ── Main ──────────────────────────────────────────────────────────────────────

if [[ "$OS" == "Darwin" ]]; then
    setup_macos
elif [[ "$OS" == "Linux" ]]; then
    setup_linux
else
    echo "Unsupported OS: $OS"
    exit 1
fi

setup_common
