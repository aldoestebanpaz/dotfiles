
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# defaults
alias diff='diff -u $@'


# Shortcurts to GUI tools
alias t='qterminal'
alias pad='featherpad'


# Get mimetype of a file for xdg-mime
# with the output we can configure the MIME database (~/.config/mimeapps.list) using
# xdg-mime too (eg. `xdg-mime default xpdf.desktop application/pdf` or `xdg-mime default chrome.desktop text/html`)
# xdg-open consumes this database
# NOTE: ~/.config/mimeapps.list has precedence for example over /etc/xdg/xdg-Lubuntu/mimeapps.list (according to the precendence listed in XDG_CONFIG_DIRS)
# /etc/xdg/xdg-Lubuntu has precedence over /etc/xdg/mimeapps.list (according to the precendence listed in XDG_CONFIG_DIRS)
# NOTE: /usr/share/applications/defaults.list and ~/.local/share/applications/mimeapps.list are deprecated
# see https://wiki.archlinux.org/title/XDG_MIME_Applications
alias mimeof='xdg-mime query filetype $@'
# Get default app for given mimetype
alias defaultof='xdg-mime query default $@'


# ls in columns
alias l='ls -CF'
# ls including hidden entries and without . and ..
alias ll='ls -AF'
# ls including hidden entries, using long listing format,
# and showing them with indicators to facilitate reading
alias lll='ls -aFl'
alias lllh='ls -aFlh'


# Search files
# eg. findfile '*.htm'
findfile() { find / -type f -iname ''$@'' 2>/dev/null; }


# search a process
alias psg='ps -eaf | grep $@'


# Fetch information
fetch_info() {
    echo Default file manager
    xdg-mime query default inode/directory
    echo Default text editor
    xdg-mime query default text/plain
    echo Default web browser
    xdg-mime query default text/html
    echo Default for http links
    xdg-mime query default x-scheme-handler/http
    echo Default for https links
    xdg-mime query default x-scheme-handler/https
    echo Default email client
    xdg-mime query default x-scheme-handler/mailto
}


# apt-get and dpkg
#
# Chech for installed packages with given string pattern
# eg. dkg_s 'git*'
# eg. dkg_s '*-desktop'
pkg_s() { dpkg -l "$@" | grep ^ii; }
#
# Get files of installed package
alias pkg_c='dpkg -L $@'
#
# Open sources file
alias apt_sources='less /etc/apt/sources.list'
