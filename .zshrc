################ Credits  #########################
# ================
# Ⓒ NewDawn0 (Tom)
# ================

################ General ##########################
#Disable mails
MAILCHECK=0

################ WM ###############################

################ Plugins  ##########################
plugins=(
  vi-mode
)

################ Exports ##########################
export TERM=xterm-256color                 # 256 color
HISTCONTROL=ignoredups:erasedups           # no duplicate entries
export EDITOR=vim
#export my aplphavantage api key
#export FZF_DEFAULT_OPTS='--color=bg+:#302D41,bg:#1E1E2E,spinner:#F8BD96,hl:#F28FAD --color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96 --color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD'

################ ZSH ##############################
source $HOME/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Vim
bindkey -v
export KEYTIMEOUT=1
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true
MODE_INDICATOR="%F{white}+%f"
INSERT_MODE_INDICATOR="%F{yellow}+%f"

# autopair plugin
source ~/zsh/plugins/zsh-autopair/autopair.zsh
autopair-init

# Pure
#fpath+=$HOME/zsh/plugins/pure
#prompt pure

# Starship
eval "$(starship init zsh)"

# p10k
#source ~/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
#ZSH_THEME="powerlevel10k/powerlevel10k"

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
autoload -U colors && colors
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

############### Aliases  ##########################
# Pacman && yay
alias pacup='sudo pacman -Syyu'
alias pacin='sudo pacman --noconfirm -S'
alias pacrm='sudo pacman -Rns'
alias pacse='pacman -Q'
alias unlock='sudo rm /var/lib/pacman/db.lck'
alias paccl='sudo pacman -Rns $(pacman -Qtdq)'
alias yayup='yay -Syyu'
alias yayin='yay --noconfirm -S'
alias yayrm='yay -Rns'
alias yayse='yay -Q'
alias yaycl='yay -Rns $(yay -Qtdq)'


# General
alias touch='create $1'
alias reload='clear; source ~/.zshrc'
alias ls='exa --long'
alias lsa='ls -a --color=auto'
alias lsall='ls -lah --color=auto'
alias lsl='exa --long'
alias lt='exa -aT --color=always --group-directories-first'
alias grep='grep --color=auto'
alias home='cd $HOME'
alias whoami='echo "you tell me"; who'
alias playwav='mpv *.wav'
alias playogg='mpv *.ogg'
alias playmp3='mpv *.mp3'
alias playavi='vlc *.avi'
alias playmov='vlc *.mov'
alias playmp4='vlc *.mp4'
alias ytdl-mp3="youtube-dl --extract-audio --audio-format mp3 "
alias ytdl="youtube-dl"
alias clearFile='cat /dev/null > $1'
alias clearhist='rm -r ~/.zsh_history'
alias search='ls -la | grep'
alias zshrce='vim ~/.zshrc'
alias superstonk='superstonk -interval 1 -symbol'
alias sshpi='ssh pi@192.168.1.124'
alias sshmac='ssh tom@192.168.1.133'
alias def='dict'

# git
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias status='git status'
alias tag='git tag'
alias ntag='git tag -a'

# mirrors
alias mirror="sudo reflector -c Switzerland --sort rate -a 6 --save /etc/pacman.d/mirrorlist"

################ Functions ########################
up () {
  local d=""
  local limit="$1"

  # Default to limit of 1
  if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
    limit=1
  fi

  for ((i=1;i<=limit;i++)); do
    d="../$d"
  done
  # perform cd. Show error if cd fails
  if ! cd "$d"; then
    echo "Couldn't go up $limit dirs.";
  fi
}
ex () {
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
getIps () {
    GREEN='\033[01;32m'
    BLUE='\033[01;34m'
    PURPLE='\033[01;35m'
    CYAN='\033[01;36m'
    NONE='\033[0m'
    seq 255 | xargs -I {} arp 192.168.1.{} | grep -v "no entry" | awk -v c=$CYAN -v g=$GREEN -v b=$BLUE -v p=$PURPLE -v n=$NONE \
    '{printf g$2n "\t" c$4n "    \t"b$6n "  "b$7n "\t"p$1n"\n"} '
}
getIpInfo () {
  CYAN='\033[01;36m'
  NONE='\033[0m'
  hostname=$(hostname)
  ip=$(ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}')
  publicIp=$(wget -qO - http://ipecho.net/plain; echo)
  macAddr=$(ifconfig en0 | awk '/ether/{print $2}')
  echo -e "$CYAN Hostname$NONE    $hostname"
  echo -e "$CYAN Local Ip$NONE    $ip"
  echo -e "$CYAN Public Ip$NONE   $publicIp"
  echo -e "$CYAN Mac Address$NONE $macAddr"
}
listalias ()
{
    ALIASES=`alias | cut -d '=' -f 1`
    echo "$COMMANDS"$'\n'"$ALIASES" | sort -u
}


################ Startup ##########################
clear
#pac
#unix
#gh-cal NewDawn0
sys-fetch
