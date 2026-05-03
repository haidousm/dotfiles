#!/bin/bash
# bootstrap.sh <ssh-target>
# Run from your Mac to configure a fresh Ubuntu VPS.
# Example: ./bootstrap.sh ubuntu-8gb-us-west
#          ./bootstrap.sh root@1.2.3.4

set -euo pipefail

TARGET="${1:-}"
if [[ -z "$TARGET" ]]; then
    echo "Usage: $0 <ssh-target>"
    echo "  ssh-target: SSH alias or user@host"
    exit 1
fi

echo "Bootstrapping $TARGET..."

ssh "$TARGET" 'bash -s' <<'REMOTE'
set -euo pipefail

echo "==> Installing system packages..."
apt-get update -qq
apt-get install -y git zsh curl wget stow tmux ripgrep

if ! command -v zoxide >/dev/null 2>&1; then
    echo "==> Installing zoxide..."
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
fi

echo "==> Installing fzf (latest)..."
FZF_VERSION="$(curl -sSL https://api.github.com/repos/junegunn/fzf/releases/latest | grep '"tag_name"' | cut -d'"' -f4 | sed 's/^v//')"
curl -sSfL "https://github.com/junegunn/fzf/releases/download/v${FZF_VERSION}/fzf-${FZF_VERSION}-linux_amd64.tar.gz" \
    | tar -xz -C /usr/local/bin fzf

echo "==> Cloning dotfiles..."
if [ -d "$HOME/dotfiles/.git" ]; then
    git -C "$HOME/dotfiles" pull --ff-only
else
    git clone https://github.com/haidousm/dotfiles.git "$HOME/dotfiles"
fi

echo "==> Installing oh-my-zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "==> Installing oh-my-zsh plugins and theme..."
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions \
        "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting \
        "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
fi

echo "==> Stowing dotfiles..."
cd "$HOME/dotfiles"
stow --adopt .
git checkout .

echo "==> Setting zsh as default shell..."
ZSH_PATH="$(which zsh)"
if [ "$SHELL" != "$ZSH_PATH" ]; then
    chsh -s "$ZSH_PATH"
fi

echo ""
echo "Done! Log out and back in to start using zsh."
echo "Tip: add ~/.gitconfig.local and ~/.zshrc.local for machine-specific config."
REMOTE
