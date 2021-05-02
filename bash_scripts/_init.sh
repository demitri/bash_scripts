
DIR=$HOME/.bash_scripts

source $DIR/aliases.sh
#source $HOME/.bash_scripts/autocomplete.sh

# Autocomplete
#
# Note: 'source' only takes one argument, '*' doesn't expand as you would think here.
#source $HOME/.bash_scripts/autocomplete/autocomplete*.sh
for f in $DIR/autocomplete/enabled/autocomplete*sh; do source $f; done

# Environment variables
source $DIR/environment.sh

source $DIR/functions.sh

# Paths
source $DIR/path.sh

# Prompt
# (see for reference: http://bash-hackers.org/wiki/doku.php/scripting/terminalcodes )
source $DIR/prompt.sh

# enable bash-completions
if [ -f "/usr/local/bash-completion/etc/profile.d/bash_completion.sh" ] ; then
    source /usr/local/bash-completion/etc/profile.d/bash_completion.sh
fi

# Other Shell Stuff
#
# this enables path tab-completion when using environment variables
#
shopt -s direxpand

