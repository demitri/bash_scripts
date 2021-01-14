#
# Autocomplete
# 
# This file defines autocompletions in the bash shell.
#
# The "-o default" flag will complete filenames/paths if there are no matches.
#
# Ref: https://www.gnu.org/software/bash/manual/html_node/Programmable-Completion-Builtins.html
#
# Multilevel completions
# Ref: https://stackoverflow.com/questions/17879322/how-do-i-autocomplete-nested-multi-level-subcommands
#
# There is a template for multilevel completions at the bottom of the file.
#

# ----------
# SSH + SCP
# ----------
# https://unix.stackexchange.com/questions/13466/can-grep-output-only-specified-groupings-that-match
function _ssh_completion() {
	#perl -ne 'print "$1 " if /^Host (.+)$/' ~/.ssh/config
	# awk '$1 == "Host" {print $2}' ~/.ssh/config  | /usr/bin/grep -v '*'
	egrep -o '^Host [a-zA-Z0-9_]+' $HOME/.ssh/config | awk '{ print $2 }'
}
# add alternates here such as logging in with a non-default user, e.g.  -> complete -W "$(_ssh_completion) user@host" ssh
complete -W "$(_ssh_completion)" ssh

function _scp_completion() {
	perl -ne 'print "$1 " if /^Host (.+)$/' ~/.ssh/config
}
complete -o default -W "$(_scp_completion)" scp

# ---------
# Mercurial
# ---------
function _hg_completion() {
    echo "add addremove annotate archive backout bisect bookmarks branch branches bundle cat clone commit copy diff export forget graft grep heads help identify import incoming init locate log manifest merge outgoing parents paths phase pull push recover remove rename resolve revert root serve showconfig status summary tag tags unbundle update verify version config dates diffs environment extensions filesets glossary hgignore hgweb merge multirevs patterns phases revisions revsets subrepos templating urls"
}
complete -W "$(_hg_completion)" hg

# ----------------
# Jupyter Notebook
# ----------------
function _ipn_completion() {
    echo "jupyter-notebook --pdb"
}
complete -o default -W "$(_ipn_completion)" ipython

# -------
# hdiutil
# -------
function _hdiutil_completion() {
	echo "attach detach verify create convert compact mount eject help info burn checksum chpass erasekeys unflatten flatten imageinfo isencrypted mountvol unmount plugins udifrez udifderez internet-enable resize segment makehybrid pmap"
}
complete -o default -W "$(_hdiutil_completion)" hdiutil

# ----------
# SVN
# ----------
#function _svn_completion() {
#    echo "add blame cat changelist checkout cleanup commit copy delete diff export help import info list lock log merge mergeinfo mkdir move patch propdel propedit propget proplist propset relocate resolve resolved revert status switch unlock update"
#	# left out "upgrade"
#}
#complete -W "$(_svn_completion)" svn

# -----------
# pip install
# -----------
_pip_install()
{
    local cur prev

    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD-1]}

	# ${COMP_CWORD} = index of word at current cursor position

	case ${COMP_CWORD} in
		1)
			#echo HERE_1, ${cur}
			;;
		2)
			#echo HERE_2, ${cur}
			COMPREPLY=($($HOME/.bash_scripts/pypi_autocomplete.py --case-insensitive --contains ${cur}))
			;;
	esac
}
complete -F _pip_install pip

# -----------------------------------
# Template for multi-level completion
# -----------------------------------
# _foo()
# {
#     local cur prev
# 
#     cur=${COMP_WORDS[COMP_CWORD]}
#     prev=${COMP_WORDS[COMP_CWORD-1]}
# 
#     case ${COMP_CWORD} in
#         1)
#         	# top level commands here
#             COMPREPLY=($(compgen -W "cmd1 cmd2" -- ${cur}))
#             ;;
#         2)
#         	# second level commands, per top level command
#             case ${prev} in
#                 'cmd1')
#                     COMPREPLY=($(compgen -W "sub1 sub2 sub3" -- ${cur}))
#                     ;;
#                 'cmd2')
#                     COMPREPLY=($(compgen -W "sub4 sub5 sub6" -- ${cur}))
#                     ;;
#             esac
#             ;;
#         *)
#             COMPREPLY=()
#             ;;
#     esac
# }
# complete -F _foo foo
