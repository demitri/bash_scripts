# ------
# Docker
# ------

# $NF == last column

_docker_image_names()
{
	local image_names=$(docker images | tail -n +2 | awk '{print $1":"$2}' | tr '\n' ' ')
	echo $image_names
}

_docker_image_ids()
{
	local image_ids=$(docker images | tail -n +2 | awk '{print $3}' | tr '\n' ' ')
	echo $image_ids
}

_docker_container_names()
{
	local container_names=$(docker ps -a | tail -n +2 | awk '{print $NF}' | tr '\n' ' ')
	echo $container_names
}

_docker_running_container_names()
{
	local container_names=$(docker ps | tail -n +2 | awk '{print $NF}' | tr '\n' ' ')
	echo $container_names
}

_docker_container_ids()
{
	local container_ids=$(docker ps -a -q | tr '\n' ' ')
	echo $container_ids
}

# COMP_CWORD --> An index into ${COMP_WORDS} of the word containing the current cursor position.
# COMP_WORDS --> An array variable consisting of the individual words in the current command line, ${COMP_LINE}.
#
# Ref: https://devmanual.gentoo.org/tasks-reference/completion/index.html

_docker_new()
{
    local cur prev
	
	# COMP_CWORD is current word position (i.e. an integer)
	
    cur=${COMP_WORDS[COMP_CWORD]} 		# last word in list of commands
    prev=${COMP_WORDS[COMP_CWORD-1]}	# second from last word in list of commands
    local word1=${COMP_WORDS[1]}		# first word after program name
    local word2=${COMP_WORDS[2]}
    local word3=${COMP_WORDS[3]}

	#echo "idx=${COMP_CWORD} word1=${word1} word2=${word2} word3=${word3}\n"

	local all_docker_commands = "help checkpoint config container image network node plugin secret service stack swarm system volume attach build commit cp create deploy diff events exec export history images import info inspect kill load login logout logs pause port ps pull push rename restart rm rmi run save search start stats stop tag top unpause update version wait"

	if [ ${COMP_CWORD} -eq 1 ]
	then
		# "1" refers to the word position
		#
		# list here the first word options after the command
		COMPREPLY=($(compgen -W "${all_docker_commands}" -- ${cur}))
	else
		case ${word1} in
			'checkpoint')
				case ${word2} in
					'create')
						local checkpoint_create_options="--help --checkpoint-dir --leave-running"
						COMPREPLY=($(compgen -W "${checkpoint_create_options} $(_docker_container_names)" -- ${cur}))
						;;
					'ls')
						local checkpoint_ls_options="--help --checkpoint-dir"
						COMPREPLY=($(compgen -W "${checkpoint_ls_options} $(_docker_container_names)" -- ${cur}))
						;;
					*)
						COMPREPLY=($(compgen -W "create list ls rm" -- ${cur}))
						;;
				esac
				;;
			'config')
				case ${word2} in
					'create')
							local config_create_options="--help --label"
							COMPREPLY=($(compgen -W "${config_create_options}" -- ${cur}))
							;;
					'inspect')
							local config_inspect_options="--format --help --pretty"
							COMPREPLY=($(compgen -W "${config_inspect_options}" -- ${cur}))
							;;
					'ls')
						# TODO
						COMPREPLY=()
						;;
					'rm')
						# TODO
						COMPREPLY=()
						;;
					*)
						local checkpoint_options="--help"
						COMPREPLY=($(compgen -W "${checkpoint_options} create list ls rm" -- ${cur}))
						;;
				esac
				;;
			*)
				COMPREPLY=($(compgen -W "${all_docker_commands}" -- ${cur}))
				;;
		esac
	fi
}

_docker()
{
    local cur prev
	
    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD-1]}
    local word1=${COMP_WORDS[1]}
    local word2=${COMP_WORDS[2]}
    local word3=${COMP_WORDS[3]}

	#echo "idx=${COMP_CWORD} word1=${word1} word2=${word2} word3=${word3}\n"

	# The command is "docker" (defined below).
	# Note that if the second level command includes a leading "--", a "--" must be placed before ${cur}.
	
	#echo "prev=${prev} / comp_cword=${COMP_CWORD}\n"
	
    case ${COMP_CWORD} in
        1)
        	# "1" refers to the word position
        	#
        	# list here the first word options after the command
            COMPREPLY=($(compgen -W "help checkpoint config container image network node plugin secret service stack swarm system volume attach build commit cp create deploy diff events exec export history images import info inspect kill load login logout logs pause port ps pull push rename restart rm rmi run save search start stats stop tag top unpause update version wait" -- ${cur}))
            ;;
        2)
            case ${prev} in
                'checkpoint')
                    COMPREPLY=($(compgen -W "create ls rm" -- ${cur}))
                    ;;
                'config')
                    COMPREPLY=($(compgen -W "create inspect ls rm" -- ${cur}))
                    ;;
                'container')
                    COMPREPLY=($(compgen -W "attach commit cp create diff exec export inspect kill logs ls pause port prune rename restart rm run start stats stop top unpause update wait" -- ${cur}))
                    ;;
                'image')
                	#echo "COMP_CWORD=${COMP_CWORD} / COMP_WORDS=${COMP_WORDS[COMP_CWORD]} / prev=${prev}\n"
                	#cur2=${COMP_WORDS[COMP_CWORD]}
                	#prev2=${COMP_WORDS[COMP_CWORD-1]}
                	case ${COMP_CWORD} in
                		2)
                			# list of commands available after "docker image"
                			#echo "blank"
							COMPREPLY=($(compgen -W "build history import inspect load ls prune pull push rm save tag" -- ${cur}))
							;;
                		3)
                			#echo "prev=${prev}"
							case ${prev} in
								'build')
									COMPREPLY=($(compgen -W "" -- ${cur}))
									;;
								'history')
									#echo "xx"
									local image_history_options="--format --help --human --no-trunc --quiet"
									COMPREPLY=($(compgen -W "$(_docker_image_names) ${image_history_options}" -- ${cur}))
									;;
								'import')
									COMPREPLY=($(compgen -W "" -- ${cur}))
									;;
								'inspect')
									COMPREPLY=($(compgen -W "" -- ${cur}))
									;;
								'load')
									COMPREPLY=($(compgen -W "" -- ${cur}))
									;;
								'ls')
									COMPREPLY=($(compgen -W "" -- ${cur}))
									;;
								'prune')
									COMPREPLY=($(compgen -W "" -- ${cur}))
									;;
								'pull')
									COMPREPLY=($(compgen -W "" -- ${cur}))
									;;
								'push')
									COMPREPLY=($(compgen -W "" -- ${cur}))
									;;
								'rm')
									COMPREPLY=($(compgen -W "" -- ${cur}))
									;;
								'save')
									COMPREPLY=($(compgen -W "" -- ${cur}))
									;;
								'tag')
									COMPREPLY=($(compgen -W "" -- ${cur}))
									;;
							*)
								COMPREPLY=()
								;;
							esac
							;;
					esac
					;;
                'network')
                    COMPREPLY=($(compgen -W "connect create disconnect inspect ls prune rm" -- ${cur}))
                    ;;
                'node')
                    COMPREPLY=($(compgen -W "demote inspect ls promote ps rm update" -- ${cur}))
                    ;;
                'plugin')
                    COMPREPLY=($(compgen -W "create disable enable inspect install ls push rm set upgrade" -- ${cur}))
                    ;;
                'secret')
                    COMPREPLY=($(compgen -W "create inspect ls rm" -- ${cur}))
                    ;;
                'service')
                    COMPREPLY=($(compgen -W "create inspect logs ls ps rm rollback scale update" -- ${cur}))
                    ;;
                'stack')
                    COMPREPLY=($(compgen -W "deploy ls ps rm services" -- ${cur}))
                    ;;
                'swarm')
                    COMPREPLY=($(compgen -W "ca init join join-token leave unlock unlock-key update" -- ${cur}))
                    ;;
                'volume')
                    COMPREPLY=($(compgen -W "create inspect ls prune rm" -- ${cur}))
                    ;;
                'attach')
                    COMPREPLY=($(compgen -W "--detach-keys --help --no-stdin --sig-proxy" -- ${cur}))
                    ;;
                'build')
                	local docker_build_options="--add-host --build-arg --cache-from --cgroup-parent --compress --cpu-period --cpu-quota --cpu-shares --cpuset-cpus --cpuset-mems --disable-content-trust --file --force-rm --help --iidfile --isolation --label --memory --memory-swap --network --no-cache --pull --quiet --rm --security-opt --shm-size --squash --stream --tag --target --ulimit"
                    COMPREPLY=($(compgen -W "${docker_build_options}" -- ${cur}))
                    ;;
                'commit')
                    COMPREPLY=($(compgen -W "--author --change --help --message --pause" -- ${cur}))
                    ;;
                'cp')
                    COMPREPLY=($(compgen -W "--archive --follow-link --help" -- ${cur}))
                    ;;
                'create')
                    COMPREPLY=($(compgen -W "--add-host --attach --blkio-weight --blkio-weight-device --cap-add --cap-drop --cgroup-parent --cidfile --cpu-period --cpu-quota --cpu-rt-period --cpu-rt-runtime --cpu-shares --cpus --cpuset-cpus --cpuset-mems --device --device-cgroup-rule --device-read-bps --device-read-iops --device-write-bps --device-write-iops --disable-content-trust --dns --dns-option --dns-search --entrypoint --env --env-file --expose --group-add --health-cmd --health-interval --health-retries --health-start-period --health-timeout --help --hostname --init --interactive --ip --ip6 --ipc --isolation --kernel-memory --label --label-file --link --link-local-ip --log-driver --log-opt --mac-address --memory --memory-reservation --memory-swap --memory-swappiness --mount --name --network --network-alias --no-healthcheck --oom-kill-disable --oom-score-adj --pid --pids-limit --privileged --publish --publish-all --read-only --restart --rm --runtime --security-opt --shm-size --stop-signal --stop-timeout --storage-opt --sysctl --tmpfs --tty --ulimit --user --userns --uts --volume --volume-driver --volumes-from --workdir" -- ${cur}))
                    ;;
                'deploy')
                    COMPREPLY=($(compgen -W "'--bundle-file' '--compose-file' '--help' '--prune' '--resolve-image' '--with-registry-auth'" -- ${cur}))
                    ;;
                'diff')
                    COMPREPLY=($(compgen -W "--help" -- ${cur}))
                    ;;
                'events')
                    COMPREPLY=($(compgen -W "--filter --format --help --since --until" -- ${cur}))
                    ;;
                'exec')
                    COMPREPLY=($(compgen -W "--detach --detach-keys --env --help --interactive --privileged --tty --user" -- ${cur}))
                    ;;
                'export')
                    COMPREPLY=($(compgen -W "--help --output string" -- ${cur}))
                    ;;
                'history')
                	local history_options="--format --help --human --no-trunc --quiet"
                    #COMPREPLY=($(compgen -W "--format --help --human --no-trunc --quiet" -- ${cur}))
                    COMPREPLY=($(compgen -W "$(_docker_image_names) ${history_options}" -- ${cur}))
                    ;;
                'images')
                    COMPREPLY=($(compgen -W "--all --digests --filter --format --help --no-trunc --quietr" -- ${cur}))
                    ;;
                'import')
                    COMPREPLY=($(compgen -W "--change --help --message" -- ${cur}))
                    ;;
                'inspect')
                    COMPREPLY=($(compgen -W "--format --help --size --type" -- ${cur}))
                    ;;
                'info')
                    COMPREPLY=($(compgen -W "--format --help" -- ${cur}))
                    ;;
                'kill')
                    COMPREPLY=($(compgen -W "--help --signal" -- ${cur}))
                    ;;
                'load')
                    COMPREPLY=($(compgen -W "--help --input --quiet" -- ${cur}))
                    ;;
                'login')
                    COMPREPLY=($(compgen -W "--help --password --password-stdin --username" -- ${cur}))
                    ;;
                'logout')
                    COMPREPLY=($(compgen -W "--help" -- ${cur}))
                    ;;
                'logs')
                    COMPREPLY=($(compgen -W "--details --follow --help --since --tail --timestamps" -- ${cur}))
                    ;;
                'pause')
                    COMPREPLY=($(compgen -W "--help" -- ${cur}))
                    ;;
                'port')
                    COMPREPLY=($(compgen -W "--help" -- ${cur}))
                    ;;
                'ps')
                    COMPREPLY=($(compgen -W "--all --filter --format --help --last --latest --no-trunc --quiet --size" -- ${cur}))
                    ;;
                'pull')
                    COMPREPLY=($(compgen -W "--all-tags --disable-content-trust --help" -- ${cur}))
                    ;;
                'push')
                    COMPREPLY=($(compgen -W "--disable-content-trust --help" -- ${cur}))
                    ;;
                'rename')
                    COMPREPLY=($(compgen -W "--help" -- ${cur}))
                    ;;
                'restart')
                    COMPREPLY=($(compgen -W "--help --time" -- ${cur}))
                    ;;
                'rm')
                	rm_options="--force --help --link --volumes "
                	#docker_container_names=$(docker ps -a | tail -n +2 | awk '{print $NF}' | tr '\n' ' ')
                	#docker_container_ids=$(docker ps -a -q | tr '\n' ' ')
                    COMPREPLY=($(compgen -W "$(_docker_container_names) $(_docker_container_ids) ${rm_options}" -- ${cur}))
                    ;;
                'rmi')
                	local rmi_options="--force --help --no-prune"
                	#docker_image_names=$(docker images | tail -n +2 | awk '{print $1":"$2}' | tr '\n' ' ')
                    COMPREPLY=($(compgen -W "$(_docker_image_names) $(_docker_image_ids) ${rmi_options}" -- ${cur}))
                    ;;
                'run')
                	local run_options="--add-host --attach --blkio-weight --blkio-weight-device --cap-add --cap-drop --cgroup-parent --cidfile --cpu-period --cpu-quota --cpu-rt-period --cpu-rt-runtime --cpu-shares --cpus --cpuset-cpus --cpuset-mems --detach --detach-keys --device --device-cgroup-rule --device-read-bps --device-read-iops --device-write-bps --device-write-iops --disable-content-trust --dns --dns-option --dns-search --entrypoint --env --env-file --expose --group-add --health-cmd --health-interval --health-retries --health-start-period --health-timeout --help --hostname --init --interactive --ip --ip6 --ipc --isolation --kernel-memory --label --label-file --link --link-local-ip --log-driver --log-opt --mac-address --memory --memory-reservation --memory-swap --memory-swappiness --mount --name --network --network-alias --no-healthcheck --oom-kill-disable --oom-score-adj --pid --pids-limit --privileged --publish --publish-all --read-only --restart --rm --runtime --security-opt --shm-size --sig-proxy --stop-signal --stop-timeout --storage-opt --sysctl --tmpfs --tty --ulimit --user --userns --uts --volume --volume-driver --volumes-from --workdir"
                    COMPREPLY=($(compgen -W "${run_options} $(_docker_image_names)" -- ${cur}))
                    ;;
                'save')
                    COMPREPLY=($(compgen -W "--help --output" -- ${cur}))
                    ;;
                'start')
                    COMPREPLY=($(compgen -W "--attach --checkpoint --checkpoint-dir --detach-keys --help  --interactive" -- ${cur}))
                    ;;
                'stats')
                    COMPREPLY=($(compgen -W "--all --format --help --no-stream" -- ${cur}))
                    ;;
                'stop')
                    COMPREPLY=($(compgen -W "--help --time $(_docker_running_container_names)" -- ${cur}))
                    ;;
                'tag')
                    COMPREPLY=($(compgen -W "--help $(_docker_image_names)" -- ${cur}))
                    ;;
                'top')
                    COMPREPLY=($(compgen -W "--help $(_docker_running_container_names)" -- ${cur}))
                    ;;
                'unpause')
                    COMPREPLY=($(compgen -W "--help" -- ${cur}))
                    ;;
                'update')
                    COMPREPLY=($(compgen -W "--blkio-weight --cpu-period --cpu-quota --cpu-rt-period --cpu-rt-runtime --cpu-shares --cpus --cpuset-cpus --cpuset-mems --help  --kernel-memory --memory --memory-reservation --memory-swap --restart" -- ${cur}))
                    ;;
                'version')
                    COMPREPLY=($(compgen -W "--format --help" -- ${cur}))
                    ;;
                'wait')
                    COMPREPLY=($(compgen -W "--help" -- ${cur}))
                    ;;
                'help')
                    COMPREPLY=($(compgen -W "checkpoint config container image network node plugin secret service stack swarm system volume attach build commit cp create deploy diff events exec export history images import info inspect kill load login logout logs pause port ps pull push rename restart rm rmi run save search start stats stop tag top unpause update version wait" -- ${cur}))
                    ;;
            esac
            ;;
        *)
            COMPREPLY=()
            ;;
    esac
}

complete -F _docker docker
