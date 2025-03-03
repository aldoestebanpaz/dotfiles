# Check if we under a colored prompt
# if the terminal has the capability
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac
#
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
else
    color_prompt=
fi


# Prompt
# Meanings:
#     \u           : the username of the current user
#     \h           : the hostname up to the first `.'
#     \w           : the current working directory
#     $(__git_ps1) : function provided when executing /etc/bash_completion.d/git-prompt
# See PROMPTING in bash(1)
if [ "$color_prompt" = yes ]; then
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[31m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '
    #PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='\u@\h:\w\$ '
fi


# Title
# If this is an xterm
case "$TERM" in
xterm*|rxvt*)
    # set the title to user@host:dir
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac
