if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

 COMPLETION_WAITING_DOTS="true"

 HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
git
tmux
zsh-autosuggestions
dirhistory
jsontools
macos
)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"

export EDITOR='nvim'
export NVM_DIR="$HOME/.nvm"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias docker-clean="docker rm -f \$(docker ps -q) && docker image rm \$(docker image ls -q)"
alias gfp="git fetch && git pull --ff-only"
alias gpb="git push -u origin \$(git symbolic-ref --short HEAD)"
alias gen-crt="go run /opt/homebrew/Cellar/go/1.21.5/libexec/src/crypto/tls/generate_cert.go --rsa-bits=2048 --host=localhost"
alias vim=nvim
alias vi=nvim
alias kc=kubectl
# alias todos='git grep -l TODO | xargs -n1 git blame | grep "$(git config user.name)" | grep TODO'
alias todos="git log -STODO --author='$(git config user.name)' -p | grep TODO"

function pleaseip() { 
  kubectl get pods -o=jsonpath="{range .items[*]}{.status.podIP}{'\n'}{end}" -l app="$1-server-$2" --namespace $1 | head -n 1 
}

# Work-specific aliases & env vars -- do not commit to git i beg
[ -s "${HOME}/.work.zshrc" ] && . "${HOME}/.work.zshrc"

eval "$(zoxide init --cmd cd zsh)"
eval "$(rbenv init - zsh)"

source <(fzf --zsh)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/fzf-git.sh

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
