
alias gl='git log --oneline --decorate'
alias gs='git status --short --branch && gl -10'
alias gd='git diff'
alias gdc='gd --cached'

##### Custom Prompt ###############
function __setprompt
{
	local LAST_COMMAND=$? # Must come first!

	# Define colors
	local LIGHTGRAY="\e[0;37m"
	local WHITE="\e[1;37m"
	local BLACK="\e[0;30m"
	local DARKGRAY="\e[1;30m"
	local RED="\e[1;31m"
	local LIGHTRED="\e[0;31m"
	local GREEN="\e[0;32m"
	local LIGHTGREEN="\e[1;32m"
	local BROWN="\e[0;33m"
	local YELLOW="\e[1;33m"
	local BLUE="\e[1;34m"
	local LIGHTBLUE="\e[0;34m"
	local MAGENTA="\e[0;35m"
	local LIGHTMAGENTA="\e[1;35m"
	local CYAN="\e[0;36m"
	local LIGHTCYAN="\e[1;36m"
	local NOCOLOR="\e[0m"

	# Show error exit code if there is one
	if [[ $LAST_COMMAND != 0 ]]; then
		PS1="\[${LIGHTRED}\]?"
	else
		PS1="\[${LIGHTGREEN}\]?"
	fi

	# Current time
	PS1+="\[${CYAN}\][\A]"

	# Current directory
	PS1+=" \[${DARKGRAY}\](\[${BROWN}\]\w\[${DARKGRAY}\])"

	# Git branch
	local git_branch="$(git branch --show-current 2> /dev/null)"
	if [ $git_branch ]; then
		PS1+=" \[${DARKGRAY}\](\[${CYAN}\]${git_branch}\[${DARKGRAY}\])"
	fi

	# Skip to the next line
	PS1+="\n"

	if [[ $EUID -ne 0 ]]; then
		PS1+="\[${LIGHTBLUE}\]\$\[${NOCOLOR}\] " # Normal user
	else
		PS1+="\[${LIGHTRED}\]\#\[${NOCOLOR}\] " # Root user
	fi

	# PS2 is used to continue a command using the \ character
	PS2="\[${DARKGRAY}\]>\[${NOCOLOR}\] "

	# PS3 is used to enter a number choice in a script
	PS3='Select a number: '

	# PS4 is used for tracing a script in debug mode
	PS4='\[${DARKGRAY}\]+\[${NOCOLOR}\] '
}

# test for color support and enable colored prompt if possible
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  PROMPT_COMMAND="__setprompt;$PROMPT_COMMAND"
else
  PS1='[\A]\u:\w \$ '
fi

