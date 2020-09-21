
export PATH=${PATH}:${HOME}/bin
export PATH=${PATH}:${HOME}/.bash_scripts/bin

_add_local_programs_to_path()
{
	# add to $PATH programs installed in /usr/local/*/bin
	#
	for dirpath in /usr/local/*
	do
		# skip soft links - optionally could ONLY use soft linked directories
		[ -L "$dirpath" ] && continue
		
		dirname=`basename $dirpath`
	
		# skip anaconda2
		[ "$dirname" = "anaconda2" ] && continue

		# skip GCC
		[ "$dirname" = "gcc-9.1" ] && continue
	
		if [ -d "$dirpath/bin" ] ; then
			export PATH=$dirpath/bin:${PATH}
		fi
	done
}

_add_local_programs_to_path

# TODO: http://www.cyberciti.biz/faq/bash-for-loop/

# $PYTHONPATH
# -----------
export PYTHONSTARTUP=$HOME/.pythonstartup
#export PYTHONPATH=...
#export PYTHONPATH=$PYTHONPATH:..
