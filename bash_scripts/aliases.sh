alias l="ls"
alias ls="ls -F"
alias ll="ls -l"
alias llh="ls -lh"
alias lc="wc -l"
#alias llc="ll | lolcat" # https://www.tecmint.com/lolcat-command-to-output-rainbow-of-colors-in-linux-terminal/
alias df="df -h"
alias scp="scp -p"
alias ssh="ssh -A -Y"
alias gerp="grep"
alias top=" top -F -R -o cpu -s 5"
alias diff='diff -r --exclude=.DS_Store '
alias json_pretty='python -mjson.tool | pygmentize -l json'
alias grep="grep --exclude-dir=__pycache__ -n"
alias pythonhttpd="python -m http.server --bind 127.0.0.1 "
alias screenhelp="echo;echo screen help;echo;echo start a new screen with name : 'screen -S <name>';echo list running screens\ \ \ \ \ \ \ \ \ : 'screen -ls'; echo attach to a running session\ \ : 'screen -x';echo attach to session name\ \ \ \ \ \ \ : 'screen -r <name>';echo detach running screen\ \ \ \ \ \ \ \ : ^a d;echo"
alias webproxy="ssh -D 8123  -C -q -N "

# create shortcut for system updates on Debian-based (e.g. Ubuntu) and Red Hat-based (e.g. Alma, Rocky) systems
if [ -f "/etc/debian_version" ]; then
    alias update='sudo apt-get update && sudo apt-get upgrade'
elif [ -f "/etc/redhat-release" ]; then
    alias update='sudo dnf upgrade -y'
fi

# alias to GNU tar if installed 
if [ -x "/usr/local/tar/bin/tar" ] ; then
    alias gtar="/usr/local/tar/bin/tar"
fi

alias grep="grep --color=auto -n"
# can also set: export GREP_OPTIONS='--color=always'
# see also: https://stackoverflow.com/questions/981601/colorized-grep-viewing-the-entire-file-with-highlighted-matches
# set highlight color for grep
# see also: https://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences
export GREP_COLORS="4;37;92"

alias chmox="chmod +x"
alias bell="echo '\007\c'"
alias echon="echo -n"
alias pdfcat="/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py"

alias jpn="jupyter notebook --pylab inline"
alias python2="/usr/local/anaconda2/bin/python"
alias conda2="/usr/local/anaconda2/bin/conda"

alias prettyjson='python -m json.tool'

# Mac stuff
alias restart_network='sudo ifconfig en0 down; sudo ifconfig en0 up'
alias restart_quicklook='qlmanage -r'
alias sshconfig='bbedit ~/.ssh/config'

# https://unix.stackexchange.com/questions/18506/recursive-statistics-on-file-types-in-directory
#alias typecount='find . -type f | sed 's/.*\.//' | sort | uniq -c'
alias typecount="find . -type f | sed -E 's/(.+)\.([a-zA-Z0-9]+)$/\2/'  | sort | uniq -c"
