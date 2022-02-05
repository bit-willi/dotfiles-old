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
alias ls="exa"
alias ll="exa -l --icons"
alias vhistory="history | peco"
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"
alias shouldideploytoday="curl -s https://shouldideploy.today/api\?tz\=UTC | jq -r '.message'"
alias vim="nvim"
alias i3-brightness-1="xrandr --output eDP1 --brightness"
alias i3-brightness-2="xrandr --output HDMI1 --brightness"
alias map="telnet mapscii.me"
alias sail='[ -f sail ] && bash sail || bash vendor/bin/sail'

# asdf configuration
# . $HOME/.asdf/asdf.sh

# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
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

