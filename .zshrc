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
dirhistory
jsontools
macos
)

source $ZSH/oh-my-zsh.sh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

export EDITOR='nvim'
export NVM_DIR="$HOME/.nvm"

alias docker-clean="docker rm -f \$(docker ps -q) && docker image rm \$(docker image ls -q)"
alias gfp="git fetch && git pull --ff-only"
alias gpb="git push -u origin \$(git symbolic-ref --short HEAD)"
alias gen-crt="go run /opt/homebrew/Cellar/go/1.21.5/libexec/src/crypto/tls/generate_cert.go --rsa-bits=2048 --host=localhost"
alias vim=nvim
alias vi=nvim
alias kc=kubectl
alias todos="git log -STODO --author='$(git config user.name)' -p | grep TODO"


# Work-specific aliases & env vars -- do not commit to git i beg
[ -s "${HOME}/.work.zshrc" ] && . "${HOME}/.work.zshrc"

eval "$(zoxide init --cmd cd zsh)"

source <(fzf --zsh)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/fzf-git.sh

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Created by `pipx` on 2024-09-26 21:52:46
export PATH="$PATH:/Users/mhaidous/.local/bin"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

