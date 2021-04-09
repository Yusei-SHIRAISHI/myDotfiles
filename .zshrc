for x in `ls $HOME/.zsh/functions`;do
    source $HOME/.zsh/functions/${x}
done

setopt auto_cd
setopt auto_menu
setopt list_packed
setopt list_types
setopt noautoremoveslash

setopt prompt_subst
autoload -U colors; colors

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "○"
zstyle ':vcs_info:git:*' unstagedstr "×"
zstyle ':vcs_info:*' formats       \
    "%F{green}%b%f %F{red}%u%f%F{red}%c%f"
zstyle ':vcs_info:*' actionformats \
    "[%F{magenta}%b|%F{red}%a%f] %F{yellow}%u%f%F{yellow}%c%f"
precmd () { vcs_info }

PROMPT="%K{green}💩%k %F{cyan}%1~%f \${vcs_info_msg_0_} \${vcs_info_msg_1_}"

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

if [[ -x "$(which dircolors)" ]];then
    eval $(dircolors)
elif [[ -x "$(which gdircolors)" ]];then
    eval $(gdircolors)
fi

zstyle ':completion:*:default' list-colors ${LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

alias la='ls -a'
alias ll='ls -l'

alias cl='clear'

