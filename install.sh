#! /bin/bash

#
# install dotfiles
#

execdatetime=$(date +%Y-%m-%d-%H:%M:%S)
currentDir=$(cd $(dirname $0); pwd)
buckupDir=$HOME/.dotfiles.buckup
[ -d ${backupDir} ] || mkdir -p ${backupDir};

makeLinksToHomeDir(){
  for x in `echo "$*"`; do
        if [ -e ${HOME}/${x} ];then
            cp -af  ${HOME}/${x} ${backupDir}/${x}.${execdatetime}.backup;
        fi
        ln -sfn ${currentDir}/${x} $HOME/${x}
  done;
}

installList=('.bashrc' '.vimrc' '.tmux.conf' '.zshrc' '.zsh.d' '.gitconfig')

makeLinksToHomeDir ${installList[@]}

exit 0;
