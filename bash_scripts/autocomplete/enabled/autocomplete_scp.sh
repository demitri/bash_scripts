# SCP Autocomplete Script with SSH Host and Remote Path Completion
# Save this file in /etc/bash_completion.d/scp_autocomplete or ~/.bash_completion

# Function to fetch SSH hostnames from ~/.ssh/config
_scp_host_completion() {
    perl -ne 'print "$1 " if /^Host (.+)$/' ~/.ssh/config
}

# Function to fetch remote directory paths dynamically
_scp_remote_path_completion() {
    local cur prev cmd server path prefix
    COMPREPLY=()

    # Get command, previous word, and current word
    cmd="${COMP_WORDS[0]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    cur="${COMP_WORDS[COMP_CWORD]}"

    # Ensure we are handling 'scp'
    if [[ "$cmd" != "scp" && "$cmd" != "rsync" ]]; then
        return 0
    fi

    # Match server:path pattern
    if [[ "$cur" =~ ^([^:]+):(.+)?$ ]]; then
        server="${BASH_REMATCH[1]}"  # Extract server name
        path="${BASH_REMATCH[2]}"   # Extract path if provided
    elif [[ "$prev" =~ ^([^:]+):(.+)?$ ]]; then
        server="${BASH_REMATCH[1]}"  # Handle space-separated paths
        path="${BASH_REMATCH[2]}"
        cur="$prev$cur"  # Combine partial paths
    else
        # No remote server pattern, complete hostnames
        COMPREPLY=($(compgen -W "$(_scp_host_completion)" -- "$cur"))
        return 0
    fi

    # Fetch remote path suggestions if hostname matches SSH config
    if [[ " $(_scp_host_completion) " == *" $server "* ]]; then
        prefix=$(dirname "$path")   # Get directory prefix
        [[ "$prefix" == "." ]] && prefix=""  # Remove default "."
        prefix="${prefix%/}/"       # Ensure trailing slash

        # Query remote directory listing with SSH
        remote_output=$(ssh -o ConnectTimeout=2 "$server" "compgen -o dirnames -- '$prefix'" 2>/dev/null)

        # Process results and add matches
        if [[ $? -eq 0 ]]; then
            COMPREPLY=($(compgen -W "$remote_output" -- "$path"))
        fi
    fi
}

# Register autocomplete for scp and rsync
complete -F _scp_remote_path_completion scp rsync
