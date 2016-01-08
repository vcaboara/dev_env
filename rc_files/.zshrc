# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31" #${(s.:.)LS_COLORS}
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' original true
zstyle ':completion:*' use-compctl false
zstyle :compinstall filename '/home/vcaboara/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
export EDITOR=vim
HISTFILE=~/.histfile
HISTSIZE=15000
SAVEHIST=15000

# Don't overwrite, append!
setopt APPEND_HISTORY
setopt extended_glob
setopt multios
setopt automenu
bindkey -e
# End of lines configured by zsh-newuser-install

# pcre: Perl Compatible Regular Expressions
zmodload zsh/pcre
autoload zmv
autoload pcre
# XXX ?
alias mmv='noglob zmv -W'

export PATH=$PATH:$HOME/bin
export ANDROID_HOME=$HOME/android-sdk-linux
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
export PATH=$PATH:$HOME/.npm-packages/bin

# persisting login environment cruft
runscreen () {
if [ ".$TERM" != ".screen" ] ; then
    if [ ".$DISPLAY" != "." ] ; then
	echo export DISPLAY=$DISPLAY >~/.periodicrc 
    fi
fi

screen -d -R
}

alias screen=runscreen

#if [ ".$TERM" = ".screen" ] ; then
#    periodic () { source ~/.periodicrc }
#
#    PERIOD=35
#fi

case $TERM in
    screen*)
	precmd () {
	    print -Pn "\ek%11<..<%1~\e\\"
	}
	preexec () {
	    # only want to update for editors, sshs, and builds
	    
	    pcre_compile "^vi|^make|^dobuild|^buildall|^scp|^less|^tail|^nethack"

	    if pcre_match "$1" ; then
		print -Pn "\ek%17<..<%1~:$1\e\\"
	    else
		# this one is different because the current dir matters less
		pcre_compile "^ssh"
		if pcre_match "$1" ; then
		    print -Pn "\ek%21<..<$1\e\\"
		fi
	    fi
	}
    ;;
esac

function title() {
    # escape '%' chars in $1, make nonprintables visible
    a=${(V)1//\%/\%\%}

    # Truncate command, and join lines.
    a=$(print -Pn "%40>...>$a" | tr -d "\n")

    case $TERM in
    screen)
    print -Pn "\e]2;$a @ $2\a" # plain xterm title
    print -Pn "\ek$a\e\\"      # screen title (in ^A")
    print -Pn "\e_$2   \e\\"   # screen location
    ;;
    xterm*|rxvt)
    print -Pn "\e]2;$a @ $2\a" # plain xterm title
    ;;
    esac
}

# precmd is called just before the prompt is printed
function precmd() {
    title "zsh" "%m(%55<...<%~)"
}

# preexec is called just before any command line is executed
function preexec() {
    title "$1" "%m(%35<...<%~)"
}

##Color table from: http://www.understudy.net/custom.html
#fg_black=%{$'\e[0;30m'%}
#fg_red=%{$'\e[0;31m'%}
#fg_green=%{$'\e[0;32m'%}
#fg_brown=%{$'\e[0;33m'%}
#fg_blue=%{$'\e[0;34m'%}
#fg_purple=%{$'\e[0;35m'%}
#fg_cyan=%{$'\e[0;36m'%}
#fg_lgray=%{$'\e[0;37m'%}
#fg_dgray=%{$'\e[1;30m'%}
#fg_lred=%{$'\e[1;31m'%}
#fg_lgreen=%{$'\e[1;32m'%}
#fg_yellow=%{$'\e[1;33m'%}
#fg_lblue=%{$'\e[1;34m'%}
#fg_pink=%{$'\e[1;35m'%}
#fg_lcyan=%{$'\e[1;36m'%}
#fg_white=%{$'\e[1;37m'%}
##Text Background Colors
#bg_red=%{$'\e[0;41m'%}
#bg_green=%{$'\e[0;42m'%}
#bg_brown=%{$'\e[0;43m'%}
#bg_blue=%{$'\e[0;44m'%}
#bg_purple=%{$'\e[0;45m'%}
#bg_cyan=%{$'\e[0;46m'%}
#bg_gray=%{$'\e[0;47m'%}
##Attributes
#at_normal=%{$'\e[0m'%}
#at_bold=%{$'\e[1m'%}
#at_italics=%{$'\e[3m'%}
#at_underl=%{$'\e[4m'%}
#at_blink=%{$'\e[5m'%}
#at_outline=%{$'\e[6m'%}
#at_reverse=%{$'\e[7m'%}
#at_nondisp=%{$'\e[8m'%}
#at_strike=%{$'\e[9m'%}
#at_boldoff=%{$'\e[22m'%}
#at_italicsoff=%{$'\e[23m'%}
#at_underloff=%{$'\e[24m'%}
#at_blinkoff=%{$'\e[25m'%}
#at_reverseoff=%{$'\e[27m'%}
#at_strikeoff=%{$'\e[29m'%}
# 
#  
PROMPT="
${fg_lgreen}%n@${at_underl}%m${at_underloff}${fg_white}[${fg_cyan}%~${fg_white}]
[${fg_green}%T${fg_white}]:${at_normal}"

force_color_prompt=yes

#Aliases
alias reload="source ~/.zshrc"

# Convenience
alias du='du -sh '
alias df='df --si '

alias sudoj='sudo -u jenkins '
alias restartj='sudo service jenkins restart'
alias stopj='sudo service jenkins stop'

alias gta='cp ~/git/playmakertabletandroid/gradleTemplates/apps/build.gradle .'
alias gtad='cp ~/git/playmakertabletandroid/gradleTemplates/apps/dependsOnChildren/build.gradle .'
alias gtl='cp ~/git/playmakertabletandroid/gradleTemplates/libs/build.gradle .'

alias play='cd ~/git/playmakertabletandroid'
alias auto='cd ~/git/automation'
alias apkinfo='~/android-sdk-linux/build-tools/19.1.0/aapt dump badging '

###ls, the common ones I use a lot shortened for rapid fire usage
alias sl=ls
alias ls='ls --color' #I like color
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias ll='ls -laFh'   #long list,show all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias '..'='cd ..'
alias '...'='cd ../..'
alias '....'='cd ../../..'
alias '.....'='cd ../../../..'
#alias -g wf='...'

# Git aliases
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit '
alias gd='git diff '
alias go='git checkout '
alias gr='git reset '
alias gp='git pull '
alias gP='git push'
alias gh='git hist '
alias gk='gitk --all&'
alias gx='gitx --all'

alias got='git '
alias get='git '
