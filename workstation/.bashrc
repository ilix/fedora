# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific aliases and functions

case $- in
  *i*) ;;
    *) return;;
esac

# PATH mods
export PATH=$PATH:/home/ilix/.local/bin

# Keep history up to date, across sessions, in realtime
#  http://unix.stackexchange.com/a/48113
export HISTCONTROL=ignoredups:erasedups         # no duplicate entries
export HISTSIZE=100000                          # big big history (default is 500)
export HISTFILESIZE=$HISTSIZE                   # big big history

shopt -s histappend;
shopt -s nocaseglob;
shopt -s cdspell;
shopt -s checkwinsize

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Custom aliases
alias discord="~/.local/Discord/Discord"
alias minecraft="java -jar ~/.local/Minecraft.jar &>/dev/null &"
alias oadm="~/.local/openshift/oadm"
alias oc="~/.local/openshift/oc"
alias sqldeveloper="sh ~/.local/sqldeveloper/sqldeveloper.sh &>/dev/null &"
alias syncthing="screen -d -m -S syncthing bash -c ""~/.local/syncthing/syncthing"""
alias vpn_up="screen -d -m -S openvpn sudo openvpn --config ~/Documents/iteam-acr.ovpn"
alias vpn_dn="sudo killall openvpn"
alias wejay="~/.local/wejay"

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export NVM_DIR="/home/ilix/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

[ -z "$PS1" ] && return

function nvmuse {
  [ -z "$PS1" ] && return
  if [ -f .nvmrc ]; then
    nvm use
  fi
}

function cd {
  builtin cd "$@"
  nvmuse
}

nvmuse