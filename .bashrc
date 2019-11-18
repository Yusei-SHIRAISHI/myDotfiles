[ -e $HOME/.zshenv ] && source $HOME/.zshenv

if [ $(uname) = 'Darwin' ];then
    alias ls="ls -G"
    if [ -f /usr/local/bin/gls ];then
        alias ls="gls --color=auto"
    fi
else
    alias ls="ls --color=auto"
fi

alias la="ls -a"
alias lal="ls -la"
alias sl="ls"
alias ll="ls -l"

alias poweroff="sudo shutdown -h now"

psgrep() {
    term=$(echo $1 | perl -pe "s/(.)(.*)/[\1]\2/")
    ps -ef | grep ${term};
}

if [ -f /usr/local/bin/tmux ]; then
    alias t="tmux";
    alias tls="tmux ls";
fi


export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
