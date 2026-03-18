# Bash completion for Claude Code CLI
# Source this file or add to your .bashrc / .bash_profile:
#   source /path/to/claude-completion.bash

_claude_completions() {
    local cur prev words cword
    _init_completion || return

    # All top-level subcommands
    local commands="agents auth doctor install mcp plugin plugins setup-token update upgrade"

    # All top-level options (long)
    local global_opts="
        --add-dir --agent --agents
        --allow-dangerously-skip-permissions --allowedTools --allowed-tools
        --append-system-prompt --betas --brief --chrome
        --continue --dangerously-skip-permissions --debug --debug-file
        --disable-slash-commands --disallowedTools --disallowed-tools
        --effort --fallback-model --file --fork-session --from-pr
        --help --ide --include-partial-messages --input-format
        --json-schema --max-budget-usd --mcp-config --mcp-debug
        --model --name --no-chrome --no-session-persistence
        --output-format --permission-mode --plugin-dir --print
        --replay-user-messages --resume --session-id --setting-sources
        --settings --strict-mcp-config --system-prompt --tmux
        --tools --verbose --version --worktree
    "

    # Short options
    local short_opts="-c -d -h -n -p -r -v -w"

    # Determine if we're completing a subcommand or a top-level option
    local subcmd=""
    local subcmd_idx=0
    for ((i = 1; i < cword; i++)); do
        case "${words[i]}" in
            agents|auth|doctor|install|mcp|plugin|plugins|setup-token|update|upgrade)
                subcmd="${words[i]}"
                subcmd_idx=$i
                break
                ;;
            -*)
                # skip options and their arguments
                ;;
        esac
    done

    # Handle option arguments
    case "$prev" in
        --effort)
            COMPREPLY=($(compgen -W "low medium high max" -- "$cur"))
            return
            ;;
        --input-format)
            COMPREPLY=($(compgen -W "text stream-json" -- "$cur"))
            return
            ;;
        --output-format)
            COMPREPLY=($(compgen -W "text json stream-json" -- "$cur"))
            return
            ;;
        --permission-mode)
            COMPREPLY=($(compgen -W "acceptEdits bypassPermissions default dontAsk plan auto" -- "$cur"))
            return
            ;;
        --model|--fallback-model)
            COMPREPLY=($(compgen -W "sonnet opus haiku claude-opus-4-6 claude-sonnet-4-6 claude-haiku-4-5-20251001" -- "$cur"))
            return
            ;;
        -t|--transport)
            COMPREPLY=($(compgen -W "stdio sse http" -- "$cur"))
            return
            ;;
        -s|--scope)
            COMPREPLY=($(compgen -W "local user project" -- "$cur"))
            return
            ;;
        --debug-file|--mcp-config|--settings|--plugin-dir)
            _filedir
            return
            ;;
        --add-dir)
            _filedir -d
            return
            ;;
    esac

    # Subcommand completions
    if [[ -n "$subcmd" ]]; then
        # Find the sub-subcommand if any
        local subsub=""
        for ((i = subcmd_idx + 1; i < cword; i++)); do
            case "${words[i]}" in
                -*)
                    ;;
                *)
                    if [[ -z "$subsub" ]]; then
                        subsub="${words[i]}"
                    fi
                    ;;
            esac
        done

        case "$subcmd" in
            auth)
                if [[ -z "$subsub" ]]; then
                    COMPREPLY=($(compgen -W "login logout status help" -- "$cur"))
                else
                    case "$subsub" in
                        login)
                            COMPREPLY=($(compgen -W "--email --sso --help" -- "$cur"))
                            ;;
                        status)
                            COMPREPLY=($(compgen -W "--help" -- "$cur"))
                            ;;
                    esac
                fi
                return
                ;;
            mcp)
                if [[ -z "$subsub" ]]; then
                    COMPREPLY=($(compgen -W "add add-from-claude-desktop add-json get list remove reset-project-choices serve help" -- "$cur"))
                else
                    case "$subsub" in
                        add)
                            COMPREPLY=($(compgen -W "--transport -t --scope -s --env -e --header -H --callback-port --client-id --client-secret --help" -- "$cur"))
                            ;;
                        add-json)
                            COMPREPLY=($(compgen -W "--scope -s --help" -- "$cur"))
                            ;;
                        remove)
                            COMPREPLY=($(compgen -W "--scope -s --help" -- "$cur"))
                            ;;
                        add-from-claude-desktop)
                            COMPREPLY=($(compgen -W "--help" -- "$cur"))
                            ;;
                        serve)
                            COMPREPLY=($(compgen -W "--debug -d --verbose --help" -- "$cur"))
                            ;;
                    esac
                fi
                return
                ;;
            install)
                if [[ -z "$subsub" ]]; then
                    COMPREPLY=($(compgen -W "stable latest --force --help" -- "$cur"))
                else
                    COMPREPLY=($(compgen -W "--force --help" -- "$cur"))
                fi
                return
                ;;
            agents)
                COMPREPLY=($(compgen -W "--setting-sources --help" -- "$cur"))
                return
                ;;
            plugin|plugins)
                if [[ -z "$subsub" ]]; then
                    COMPREPLY=($(compgen -W "disable enable install i list marketplace uninstall remove update validate help" -- "$cur"))
                else
                    case "$subsub" in
                        marketplace)
                            # Find sub-sub-subcommand
                            local subsubsub=""
                            for ((i = subcmd_idx + 2; i < cword; i++)); do
                                case "${words[i]}" in
                                    -*)
                                        ;;
                                    marketplace)
                                        ;;
                                    *)
                                        if [[ -z "$subsubsub" ]]; then
                                            subsubsub="${words[i]}"
                                        fi
                                        ;;
                                esac
                            done
                            if [[ -z "$subsubsub" ]]; then
                                COMPREPLY=($(compgen -W "add list remove rm update help" -- "$cur"))
                            fi
                            ;;
                        install|i|uninstall|remove|update|enable|disable)
                            COMPREPLY=($(compgen -W "--help" -- "$cur"))
                            ;;
                        validate)
                            _filedir
                            ;;
                    esac
                fi
                return
                ;;
            doctor|setup-token|update|upgrade)
                COMPREPLY=($(compgen -W "--help" -- "$cur"))
                return
                ;;
        esac
    fi

    # Top-level completion
    if [[ "$cur" == --* ]]; then
        COMPREPLY=($(compgen -W "$global_opts" -- "$cur"))
    elif [[ "$cur" == -* ]]; then
        COMPREPLY=($(compgen -W "$short_opts $global_opts" -- "$cur"))
    else
        COMPREPLY=($(compgen -W "$commands" -- "$cur"))
    fi
}

complete -F _claude_completions claude
