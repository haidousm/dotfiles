if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

plugins=(
git
tmux
zsh-autosuggestions
zsh-syntax-highlighting
dirhistory
jsontools
)

source $ZSH/oh-my-zsh.sh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

export EDITOR='nvim'
export NVM_DIR="$HOME/.nvm"

alias docker-clean="docker rm -f \$(docker ps -q) && docker image rm \$(docker image ls -q)"
alias gfp="git fetch && git pull --ff-only"
alias gpb="git push -u origin \$(git symbolic-ref --short HEAD)"
alias vim=nvim
alias vi=nvim
alias kc=kubectl
alias todos="git log -STODO --author='$(git config user.name)' -p | grep TODO"
alias sbtest="sbt test 2>&1 1>/dev/null"

# Work-specific aliases & env vars -- do not commit to git i beg
[ -s "${HOME}/.work.zshrc" ] && . "${HOME}/.work.zshrc"

command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init --cmd cd zsh)"

command -v fzf >/dev/null 2>&1 && source <(fzf --zsh)
[ -s ~/fzf-git.sh ] && source ~/fzf-git.sh

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Machine-local overrides (Homebrew paths, work tools, credentials — never committed)
[ -s ~/.zshrc.local ] && source ~/.zshrc.local
