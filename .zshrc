for x in `ls $HOME/.zsh.d/`;do
    source $HOME/.zsh.d/${x}
done

setopt SH_WORD_SPLIT

setopt auto_cd
setopt auto_menu
setopt list_packed
setopt list_types
setopt noautoremoveslash

setopt prompt_subst
autoload -U colors; colors
autoload -Uz add-zsh-hook

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:*' formats       \
    "[%F{green}%b%f] %m"
zstyle ':vcs_info:*' actionformats \
    "[%F{magenta}%b|%F{red}%a%f] %m"
zstyle ':vcs_info:git+set-message:*' hooks \
	git_set_status_to_misc

function +vi-git_set_status_to_misc() {
  if [[ "$hook_com[staged]" == "S" ]] || [[ "$hook_com[unstaged]" == "U" ]]; then
    hook_com[misc]="×"
  elif [[ -z "$(git log $hook_com[branch]..origin/$hook_com[branch])" ]]; then
    hook_com[misc]="↑"
  elif [[ -z "$(git log origin/$hook_com[branch]..$hook_com[branch])" ]]; then
    hook_com[misc]="↓"
  else
    hook_com[misc]="○"
  fi
	return 0
}

precmd () { vcs_info }

PROMPT="%K{green}💩%k %F{cyan}%1~%f \${vcs_info_msg_0_}"
add-zsh-hook precmd update_prompt
function update_prompt() {
  if [[ $? -eq 0 ]]; then
		exit_status_color='green'
	else
		exit_status_color='red'
	fi
  PROMPT="%K{${exit_status_color}}💩%k %F{cyan}%1~%f \${vcs_info_msg_0_} "
}


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

