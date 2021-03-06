# My custom .zshrc
# https://github.com/alexanderczigler/.env

ENV_LOCATION="$HOME/GitHub/.env"

# Aliases

alias gp="git pull --rebase --autostash"
alias v2resetdb="docker-compose down && docker volume rm v2_db-data || true && docker-compose up -d"
alias v2envrc="cp ~/Documents/v2.api.envrc ~/Code/v2/api/.envrc && cp ~/Documents/v2.cabby.envrc ~/Code/v2/cabby/.envrc && cp ~/Documents/v2.web.env ~/Code/v2/web/.env"
alias eks_mrf="aws --profile motorbranschen eks --region eu-north-1 update-kubeconfig --name ci"
alias eks_iteam="aws --profile iteam eks --region eu-north-1 update-kubeconfig --name gitlab-eks"

# Completions

autoload -Uz compinit
compinit

source <(kubectl completion zsh)

# Refresh .zshrc and other files from the .env repo

zup () {
  echo " -> Update .zshrc"
  _zup_rc

  echo " -> Update SSH config"
  _zup_ssh

  echo " -> Reload .zshrc"
  source "$HOME/.zshrc"
}

_zup_rc () {
  cp "$ENV_LOCATION/.zshrc" "$HOME/.zshrc"
}

_zup_ssh () {
  cp "$ENV_LOCATION/.ssh/config" "$HOME/.ssh/config"
}

# direnv

eval "$(direnv hook zsh)"

# nvm

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

nvmuse () {
  [ -z "$PS1" ] && return
  if [[ $PWD == $prev_pwd ]]; then
    return
  fi

  prev_pwd=$PWD
  if [[ -f ".nvmrc" ]]; then
    eval "nvm use" >/dev/null

    if [[ "$?" == "3" ]]; then
      eval "nvm install" >/dev/null
    fi

    nvm_dirty="1"
  elif [[ "$nvm_dirty" == "1" ]]; then
    eval "nvm use default" >/dev/null
    nvm_dirty="0"
  fi
}

function cd {
  builtin cd "$@"
  nvmuse
}