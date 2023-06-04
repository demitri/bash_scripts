
# see paths.sh for $PYTHONPATH $DYLD_LIBRARY_PATH $DYLD_FALLBACK_LIBRARY_PATH

export EDITOR=/usr/bin/vi

# command link colors
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad

# See: https://unix.stackexchange.com/questions/258679/why-is-ls-suddenly-wrapping-items-with-spaces-in-single-quotes
export QUOTING_STYLE=literal

# remove duplicate commands from bash history
# Ref: https://unix.stackexchange.com/a/265649/190451
#export HISTCONTROL=ignoredups
export HISTCONTROL=ignoreboth:erasedups

# grep & ack
# also see: https://beyondgrep.com (ack)
#export GREP_OPTIONS="--exclude-dir=__pycache__" # deprecated; place options in alias
export ACK_COLOR_MATCH="bold underline magenta"

export SRC=/usr/local/src

export HOMEBREW_NO_ANALYTICS=1

export JULIA_NUM_THREADS=auto

# Ref: https://stackoverflow.com/questions/54429210/how-do-i-prevent-conda-from-activating-the-base-environment-by-default
export CONDA_AUTO_ACTIVATE_BASE=false

# pkg-config paths
# ----------------
_add_local_programs_to_pkgconfig()
{
	# build dynamically from directories in /usr/local/
	#
	for dirpath in /usr/local/*
	do
		DIRNAME=`basename $dirpath`
	
		# skip directories named below
		[ $DIRNAME = "anaconda" ]  && continue
		[ $DIRNAME = "anaconda2" ] && continue
		[ $DIRNAME = "share" ]     && continue
		[ $DIRNAME = "src" ]       && continue

		# skip soft links
		[ -L "$dirpath" ] && continue					
	
		if [ -d "$dirpath/lib/pkgconfig" ] ; then
			if [ -z "$PKG_CONFIG_PATH" ] ; then
				export PKG_CONFIG_PATH="$dirpath/lib/pkgconfig"
			else
				export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$dirpath/lib/pkgconfig"
			fi
		fi
	done

	# add any others by hand
	export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/usr/local/bash-completion-2.9/share/pkgconfig"
}

_add_local_programs_to_pkgconfig

