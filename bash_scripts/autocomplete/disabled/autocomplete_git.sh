#
# Bash autocomplete script for Git.
#
# Ref: https://debian-administration.org/article/317/An_introduction_to_bash_completion_part_2
#
# COMP_WORDS : An array variable consisting of the individual words in the current command line.
# COMP_CWORD : An index into ${COMP_WORDS} of the word containing the current cursor position.

# ---------
# Git
# ---------
_git()
{
	local files=`ls .`

    local cur prev

    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD-1]}

    case ${COMP_CWORD} in
        1)
        	# top level commands here
            COMPREPLY=($(compgen -W "clone init add mv reset rm bisect grep log show status branch checkout commit diff merge rebase tag fetch pull push --version --help --exec-path --html-path --man-path --info-path --paginate --no-pager --no-replace-objects --bare --git-dir --work-tree --namespace" -- ${cur}))
            ;;
        2)
        	# second level commands, per top level command
            case ${prev} in
                'clone')
                    COMPREPLY=($(compgen -W "--verbose --quiet --progress --no-checkout --bare --mirror --local --no-hardlinks --shared --recurse-submodules[=<pathspec>] --jobs --template --reference --reference-if-able --dissociate --origin --branch --upload-pack --depth --shallow-since --shallow-exclude --single-branch --shallow-submodules --separate-git-dir --config --ipv4 --ipv6" -- ${cur}))
                    ;;
                'add')
                    COMPREPLY=($(compgen -W "--help --verbose --dry-run --force --interactive --patch --edit --update --intent-to-add --refresh --ignore-errors --ignore-missing" -- ${cur}))
                    ;;
                'reset')
                    COMPREPLY=($(compgen -W "--help --patch --soft --mixed --hard --merge --keep" -- ${cur}))
                    ;;
                'rm')
                    COMPREPLY=($(compgen -W "--help --force --cached --ignore-unmatch --quiet" -- ${cur}))
                    ;;
				'mv')
					case ${COMP_CWORD} in
						2)
							# list of commands available after "git mv"
							COMPREPLY=($(compgen -W "--force -k --dry-run --verbose ${files}" -- ${cur}))
							;;
						*)
							COMPREPLY=()
							;;
					esac
					;;
                'bisect')
                    COMPREPLY=($(compgen -W "start bad new good old terms skip reset visualize replay log run help" -- ${cur}))
                    ;;
                'grep')
                    COMPREPLY=($(compgen -W "--help --text --textconv --ignore-case --word-regexp --invert-match --full-name --extended-regexp --basic-regexp --perl-regexp --fixed-strings --line-number --files-with-matches --files-without-match --open-files-in-pager --null --count --all-match --quiet --max-depth --color --no-color --break --heading --show-function --function-context --threads --and --or --not --recurse-submodules --parent-basename --exclude-standard --no-exclude-standard --cached --no-index --untracked" -- ${cur}))
                    ;;
                'log')
                    COMPREPLY=($(compgen -W "--help --binary-files --color=when --context --directories --label --line-buffered --null" -- ${cur}))
                    ;;
                'show')
                    COMPREPLY=($(compgen -W "--help" -- ${cur}))
                    ;;
                'status')
                    COMPREPLY=($(compgen -W "--help --short --branch --porcelain --long --verbose --untracked-files --ignore-submodules --ignore --column --no-column" -- ${cur}))
                    ;;
                'branch')
                    COMPREPLY=($(compgen -W "--help --color --no-color --list --abbrev --no-abbrev --column --no-column --sort --merged --no-merged --contains --no-contains --points-at --format --set-upstream --track --no-track --set-upstream-to --unset-upstream --edit-description" -- ${cur}))
                    ;;
                'checkout')
                    COMPREPLY=($(compgen -W "--help --orphan --ours --theirs --conflict --patch" -- ${cur}))
                    ;;
                'commit')
                    COMPREPLY=($(compgen -W "--help --interactive --patch --amend --dry-run --fixup --squash --reset-author --allow-empty --allow-empty-message --no-verify --author= --date= --cleanup= --no-status --status" -- ${cur}))
                    ;;
                'diff')
                    COMPREPLY=($(compgen -W "--help --cached --no-index" -- ${cur}))
                    ;;
                'merge')
                    COMPREPLY=($(compgen -W "--help --stat --no-commit --squash --no-edit --edit --allow-unrelated-histories --no-allow-unrelated-histories --rerere-autoupdate --no-rerere-autoupdate --abort --continue" -- ${cur}))
                    ;;
                'rebase')
                    COMPREPLY=($(compgen -W "--help --interactive --exec --onto --continue --skip --abort --quit --edit-todo" -- ${cur}))
                    ;;
                'tag')
                    COMPREPLY=($(compgen -W "--help --contains --points-at --column= --no-column --create-reflog --sort --format --merged --no-merged" -- ${cur}))
                    ;;
                'fetch')
                    COMPREPLY=($(compgen -W "--help --multiple --all" -- ${cur}))
                    ;;
                'pull')
                    COMPREPLY=($(compgen -W "--help" -- ${cur}))
                    ;;
                'push')
                    COMPREPLY=($(compgen -W "--help --all --mirror --tags --follow-tags --atomic --dry-run --receive-pack= --repo= --force --delete --prune --verbose --set-upstream --push-option= --signed --no-signed --sign=(true|false|if-asked) --force-with-lease --no-verify" -- ${cur}))
                    ;;
            esac
            ;;
        *)
            COMPREPLY=()
            ;;
    esac
}
complete -F _git git
