
# History
# Don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
# Append to the history file, and don't overwrite it
# This allows to save all executions at the history
# even when running multiple bash instances in parallel
shopt -s histappend
# Use the last HISTSIZE lines that were run to save in history,
# and only keep HISTFILESIZE lines in the history
# See HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000


# Windows size check
# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# Pattern enhacement
# Enable the pattern "**" when used in a pathname expansion context
# With this it will match all files and zero or more directories and subdirectories.
shopt -s globstar


# Enable programmable completion features
# NOTE it should find and run /etc/bash_completion.d/git-prompt,
# which brings the function __git_ps1 for PS1
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Configure PATH
if [ -f ~/dotfiles/bashrc_pathvar.sh ]; then
    . ~/dotfiles/bashrc_pathvar.sh
fi

# Configure the prompt
if [ -f ~/dotfiles/bashrc_prompt.sh ]; then
    . ~/dotfiles/bashrc_prompt.sh
fi

# Additions - Alias definitions
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/dotfiles/bashrc_aliases.sh ]; then
    . ~/dotfiles/bashrc_aliases.sh
fi

# EXTRA FILES NOT UPLOADED TO GITHUB
dotfiles_private_rc_dir=~/dotfiles/private_rc
if [ -d "$dotfiles_private_rc_dir" ]; then
  for f in `ls $dotfiles_private_rc_dir`; do
    rc_file="$dotfiles_private_rc_dir/$f"
    if [ -f "$rc_file" ]; then source $rc_file; fi
  done
fi
unset rc_file
unset dotfiles_private_rc_dir
