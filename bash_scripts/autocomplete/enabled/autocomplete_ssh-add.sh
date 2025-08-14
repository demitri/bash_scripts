# Bash completion for ssh-add
# Supports OpenSSH flags and Apple keychain long options.

_ssh_add__have_compopt() { type compopt >/dev/null 2>&1; }

_ssh_add__is_flag() {
  [[ $1 == -* ]]
}

_ssh_add__join_unique() {
  # join unique words from stdin
  awk '{for(i=1;i<=NF;i++) if(!seen[$i]++) out[++n]=$i} END{for(i=1;i<=n;i++) print out[i]}'
}

_ssh_add__list_hosts() {
  # Gather hosts from ssh config and known_hosts (skip hashed entries)
  {
    # From ssh config: Host lines (ignore patterns with '*' and negations)
    for f in "$HOME/.ssh/config" "/etc/ssh/ssh_config"; do
      [[ -r $f ]] || continue
      # Extract words after 'Host', split, drop wildcards/negations
      awk 'tolower($1)=="host"{
             for(i=2;i<=NF;i++){
               h=$i
               if(h ~ /\*/ || h ~ /\?/ || h ~ /^!/) next
               print h
             }
           }' "$f"
    done

    # From known_hosts: first field (comma-separated hosts), skip hashed lines starting with '|'
    for f in "$HOME/.ssh/known_hosts" "$HOME/.ssh/known_hosts2" "/etc/ssh/ssh_known_hosts" "/etc/ssh/ssh_known_hosts2"; do
      [[ -r $f ]] || continue
      awk '$1 !~ /^\|/ { split($1,a,","); for(i in a) if(a[i] !~ /^\[/) print a[i] }' "$f"
    done
  } | _ssh_add__join_unique
}

_ssh_add__complete_files() {
  # file completion helper
  _ssh_add__have_compopt && compopt -o filenames
  COMPREPLY=( $(compgen -f -- "$cur") )
}

_ssh_add() {
  local cur prev words cword
  COMPREPLY=()
  _init_completion -n : || {
    # Fallback if bash-completion isn't available
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    words=("${COMP_WORDS[@]}")
    cword=$COMP_CWORD
  }

  # Full set of options (OpenSSH 8.9+ / 9.x) plus Apple long opts
  local -a opts=(
    -C -c -D -d -E -H -h -K -k -L -l -q -S -s -T -t -v -X -x
    --apple-use-keychain --apple-load-keychain
  )

  # If completing an option’s argument, handle here.
  case "$prev" in
    -E)
      COMPREPLY=( $(compgen -W "md5 sha256" -- "$cur") )
      return 0
      ;;
    -t)
      # Lifetime: seconds or sshd_config-style times (e.g., 300 1h 8h 1d)
      COMPREPLY=( $(compgen -W "60 300 900 3600 2h 8h 1d" -- "$cur") )
      return 0
      ;;
    -H)
      _ssh_add__complete_files
      return 0
      ;;
    -s|-e|-S)
      # Libraries: lib*.so, *.so, *.dylib – but just offer files
      _ssh_add__complete_files
      return 0
      ;;
    -h)
      # Destination constraints: suggest hosts and simple src>dst skeleton
      local hosts
      hosts="$(_ssh_add__list_hosts)"
      COMPREPLY=( $(compgen -W "$hosts" -- "$cur") )
      # If user typed something including '>', try completing the right side.
      if [[ $cur == *">"* ]]; then
        local rhs="${cur#*>}"
        local lhs="${cur%%>*}"
        local cand
        cand=$(printf '%s\n' "$hosts" | sed 's/[[:space:]]\+$//' )
        COMPREPLY=( $(compgen -W "$cand" -- "$rhs") )
        COMPREPLY=( "${COMPREPLY[@]/#/$lhs>}" )
      fi
      return 0
      ;;
    -T|-d)
      # Prefer public keys for -T (test) and -d (remove), but allow private too
      _ssh_add__have_compopt && compopt -o filenames
      # Offer .pub first, then others
      local pubs privs
      pubs=$(compgen -G "$HOME/.ssh/*.pub")
      privs=$(compgen -G "$HOME/.ssh/id_*")
      COMPREPLY=( $(compgen -W "$pubs $privs" -- "$cur") )
      return 0
      ;;
    --apple-use-keychain|--apple-load-keychain)
      # These take optional paths like normal identity arguments
      _ssh_add__complete_files
      return 0
      ;;
  esac

  # If completing an option flag
  if _ssh_add__is_flag "$cur"; then
    COMPREPLY=( $(compgen -W "${opts[*]}" -- "$cur") )
    return 0
  fi

  # Otherwise, complete identity files (default args)
  # Prefer private key files in ~/.ssh that are not *.pub
  _ssh_add__have_compopt && compopt -o filenames
  local keys
  # Common key names; also offer any non-.pub files under ~/.ssh
  keys=$(compgen -G "$HOME/.ssh/id_*"; compgen -G "$HOME/.ssh/*" | grep -vE '\.pub$')
  COMPREPLY=( $(compgen -W "$keys" -- "$cur") )
}

# Register completion
complete -F _ssh_add ssh-add
