# general
export ZSH="/home/willian/.oh-my-zsh"
export PATH="/home/willian/.local/bin/":$PATH

ZSH_THEME="robbyrussell"

plugins=(
    git
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# aliases
alias at="tmux a -t 0"
alias ls="exa"
alias ll="exa -l --icons"
alias vhistory="history | peco"
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"
alias shouldideploytoday="curl -s https://shouldideploy.today/api\?tz\=UTC | jq -r '.message'"
alias vim="nvim"
alias v="nvim ."
alias i3-brightness-1="xrandr --output eDP-1 --brightness"
alias i3-brightness-2="xrandr --output HDMI-1 --brightness"
# Defaul 7500
alias brightness="sudo vim /sys/class/backlight/intel_backlight/brightness"
alias map="telnet mapscii.me"
alias sail='[ -f sail ] && bash sail || bash vendor/bin/sail'
alias mkdir-date='mkdir $(date +"%Y-%m-%d")'
alias touch-date='touch $(date +"%Y-%m-%d").txt'
alias c='clear'
alias ocaml='rlwrap ocaml'
alias \?='tldr'

# initialise completions with ZSH's compinit
autoload -Uz compinit
compinit

vv() {
    findOutput=$(find . | ag -v '(vendor|node_modules|phpintel|debugbar|cache|.git/)' | peco)

    if [ ! -z "$findOutput" ]
    then
        echo $findOutput
        nvim $findOutput
    fi
}

watch() {
    echo "---- Running watch ----"
    echo "Path to monitor '$1' \nCommand to run '$2'"
    find . $1 2> /dev/null | grep -v '^.$' | entr sh -c $2
}

# opam configuration
[[ ! -r /home/willian/.opam/opam-init/init.zsh ]] || source /home/willian/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# asdf configuration
. /opt/asdf-vm/asdf.sh

# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
