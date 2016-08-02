export EDITOR=nvim

HISTSIZE=10000
SAVEHIST=10000

export PATH=$PATH:$HOME/bin

force_color_prompt=yes

# Convenience
alias du='du -sh '
alias df='df --si '
alias tre='tree '

alias sl=ls
alias ls='ls --color' # color
alias l='ls -lFh'     # size,show type,human readable
alias la='ls -lAFh'   # long list,show almost all,show type,human readable
alias ll='ls -laFh'   # long list,show all,show type,human readable
alias lr='ls -tRFh'   # sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   # long list,sorted by date,show type,human readable
alias '..'='cd ..'
alias '...'='cd ../..'
alias '....'='cd ../../..'
alias '.....'='cd ../../../..'
alias iotop='sudo iotop '
#alias -g wf='...'

# Docker/-compose/-machine
alias dk='docker '
alias dki='docker images '
alias dkia='docker images -a '
alias dkv='docker volume '
alias dkvl='docker volume ls'
alias dkcleanrun='docker ps -aq | xargs --no-run-if-empty docker rm -f'
alias dkcleanvol='docker run -v /var/run/docker.sock:/var/run/docker.sock \
	-v /var/lib/docker:/var/lib/docker \
	--privileged dockerinpractice/docker-cleanup-volumes'
alias dkrmvols='dkv rm $(docker volume ls -q)'
alias dkrmnone='dk rmi $(dkia | grep none | awk "{ print $3 }")'

alias dc='docker-compose '
alias dcu='dc up '
alias dcub='dc up --build '
alias dcud='dcu -d '
alias dcudb='dcud --build '
alias dcubd='dcudb '
alias dcd='dc down '
alias dcdv='dcd -v '

alias dm='docker-machine '
alias dmls='docker-machine ls'
alias dmload='eval $(dm env)'

# Git aliases
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit '
alias gd='git diff '
alias go='git checkout '
alias gr='git reset '
alias grb='git rebase '
alias gp='git pull '
alias gP='git push'
alias gh='git hist '
alias gk='gitk --all& '
alias gx='gitx --all '

alias got='git '
alias get='git '

