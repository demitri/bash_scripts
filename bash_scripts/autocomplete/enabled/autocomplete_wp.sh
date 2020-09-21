# ----------------------------------------------
# Bash autocomplete script for the WordPress CLI
# ----------------------------------------------
#
# For Bash users, source this file in your shell (e.g. ~/.bashrc)
# to enable autocompletion of "wp" commands.
#
_wp_cli()
{
	# ${COMP_CWORD} = index of word at current cursor position
	
    local cur=${COMP_WORDS[COMP_CWORD]}
    local prev=${COMP_WORDS[COMP_CWORD-1]}
    local word1=${COMP_WORDS[1]} # COMP_WORDS[0] is the command ("wp")
    local word2=${COMP_WORDS[2]}
    local word3=${COMP_WORDS[3]}

	local all_wp_commands="cache cap cli comment config core cron db embed eval eval-file export help i18n import language media menu network option package plugin post post-type rewrite role scaffold search-replace server shell sidebar site super-admin taxonomy term theme transient user widget"
	local wp_global_options="--path=<path> --url=<url> --ssh=[<scheme>:][<user>@]<host|container>[:<port>][<path>] --http=<http> --user=<id|login|email> --skip-plugins[=<plugins>] --skip-themes[=<themes>] --skip-packages --require=<path> --no-color --color --debug[=<group>] --prompt[=<assoc>] --quiet"
	
	if [ ${COMP_CWORD} -eq 1 ]
	then
		# completion list after "wp"
		COMPREPLY=($(compgen -W "${all_wp_commands} ${wp_global_options}" -- ${cur}))
	else
		case ${word1} in
			'cache')
				case ${word2} in
					'add')
						echo " <key> <value> [<group>] [<expiration>]"
						COMPREPLY=()
						#COMPREPLY=($(compgen -W "[key] [value] [group] [expiration]" -- ${cur}))
						;;
					'decr')
						COMPREPLY=($(compgen -W "<key> <offset> <group>" -- ${cur}))
						;;
					'delete')
						COMPREPLY=($(compgen -W "<key> <group>" -- ${cur}))
						;;
					'flush')
						COMPREPLY=()
						;;
					'get')
						COMPREPLY=($(compgen -W "<key> <group>" -- ${cur}))
						;;
					'incr')
						COMPREPLY=($(compgen -W "<key> <offset> <group>" -- ${cur}))
						;;
					'replace')
						COMPREPLY=($(compgen -W "<key> <value> <group> <expiration>" -- ${cur}))
						;;
					'set')
						COMPREPLY=($(compgen -W "<key> <value> <group> <expiration>" -- ${cur}))
						;;
					'type')
						COMPREPLY=()
						;;
					*)
						COMPREPLY=($(compgen -W "add decr delete flush get incr replace set type" -- ${cur}))
						;;
				esac
				;;
			'cap')
				case ${word2} in
					'add')
						COMPREPLY=($(compgen -W "<role> <cap> --grant" -- ${cur}))
						;;
					'list')
						COMPREPLY=($(compgen -W "<role> --format=<format> --show-grant" -- ${cur}))
						;;
					'remove')
						# this doesn't work - all options have angle brackets
						COMPREPLY=($(compgen -W "<role> <cap>" -- ${cur}))
						;;
					*)
						COMPREPLY=($(compgen -W "add list remove" -- ${cur}))
						;;
				esac
				;;
			'cli')
				COMPREPLY=($(compgen -W "alias check-update cmd-dump completions has-command info param-dump update version" -- ${cur}))
				;;
			'comment')
				COMPREPLY=($(compgen -W "approve count create delete exists generate get list meta recount spam status trash unapprove unspam untrash update" -- ${cur}))
				;;
			'config')
				COMPREPLY=($(compgen -W "create delete edit get has list path set shuffle-salts" -- ${cur}))
				;;
			'core')
				case ${word2} in
					'check-update')
						COMPREPLY=($(compgen -W "--minor --major --field=<field> --fields=<fields> --format=<format>" -- ${cur}))
						;;
					'download')
						COMPREPLY=($(compgen -W "--path=<path> --locale=<locale> --version=<version> --skip-content --force" -- ${cur}))
						;;
					'install')
						COMPREPLY=($(compgen -W "--url=<url> --title=<site-title> --admin_user=<username> --admin_password=<password> --admin_email=<email> --skip-email" -- ${cur}))
						;;
					'is-installed')
						COMPREPLY=($(compgen -W "--network" -- ${cur}))
						;;
					'multisite-convert')
						COMPREPLY=($(compgen -W "--title=<network-title> --base=<url-path> --subdomains" -- ${cur}))
						;;
					'multisite-install')
						COMPREPLY=($(compgen -W "--url=<url>] --base=<url-path> --subdomains --title=<site-title> --admin_user=<username> --admin_password=<password> --admin_email=<email> --skip-email --skip-config" -- ${cur}))
						;;
					'update')
						COMPREPLY=($(compgen -W "<zip> --minor --version=<version> --force --locale=<locale>" -- ${cur}))
						;;
					'update-db')
						COMPREPLY=($(compgen -W "--network --dry-run" -- ${cur}))
						;;
					'verify-checksums')
						COMPREPLY=($(compgen -W "--version=<version> --locale=<locale>" -- ${cur}))
						;;
					'version')
						COMPREPLY=($(compgen -W "--extra" -- ${cur}))
						;;
					*)
						COMPREPLY=($(compgen -W "check-update download install is-installed multisite-convert multisite-install update update-db verify-checksums version" -- ${cur}))
						;;
				esac
				;;
			'cron')
				COMPREPLY=($(compgen -W "event schedule test" -- ${cur}))
				;;
			'db')
				COMPREPLY=($(compgen -W "check clean cli columns create drop export import optimize prefix query repair reset search size tables" -- ${cur}))
				;;
			'embed')
				COMPREPLY=($(compgen -W "cache fetch handler provider" -- ${cur}))
				;;
			#'eval')
			#    COMPREPLY=($(compgen -W "" -- ${cur}))
			#    ;;
			#'eval-file')
			#    COMPREPLY=($(compgen -W "" -- ${cur}))
			#    ;;
			#'export')
			#    COMPREPLY=($(compgen -W "" -- ${cur}))
			#    ;;
			'help')
				case ${word2} in
					'cache')
						COMPREPLY=($(compgen -W "add decr delete flush get incr replace set type" -- ${cur}))
						;;
					'cap')
						COMPREPLY=($(compgen -W "add list remove" -- ${cur}))
						;;
					'cli')
						COMPREPLY=($(compgen -W "alias check-update cmd-dump completions has-command info param-dump update version" -- ${cur}))
						;;
					'comment')
						COMPREPLY=($(compgen -W "approve count create delete exists generate get list meta recount spam status trash unapprove unspam untrash update" -- ${cur}))
						;;
					'config')
						COMPREPLY=($(compgen -W "create delete edit get has list path set shuffle-salts" -- ${cur}))
						;;
					'core')
						COMPREPLY=($(compgen -W "check-update download install is-installed multisite-convert multisite-install update update-db verify-checksums version" -- ${cur}))
						;;
					'cron')
						COMPREPLY=($(compgen -W "event schedule test" -- ${cur}))
						;;
					'db')
						COMPREPLY=($(compgen -W "check clean cli columns create drop export import optimize prefix query repair reset search size tables" -- ${cur}))
						;;
					'embed')
						COMPREPLY=($(compgen -W "cache fetch handler provider" -- ${cur}))
						;;
					#'eval')
					#	COMPREPLY=($(compgen -W "" -- ${cur}))
					#	;;
					#'eval-file')
					#	COMPREPLY=($(compgen -W "" -- ${cur}))
					#	;;
					#'export')
					#	COMPREPLY=($(compgen -W "" -- ${cur}))
					#	;;
					'help')
						COMPREPLY=($(compgen -W "${all_wp_commands}" -- ${cur}))
						;;
					'i18n')
						COMPREPLY=($(compgen -W "make-pot" -- ${cur}))
						;;
					#'import')
					#	COMPREPLY=($(compgen -W "" -- ${cur}))
					#	;;
					'language')
						COMPREPLY=($(compgen -W "core plugin theme" -- ${cur}))
						;;
					'media')
						COMPREPLY=($(compgen -W "image-size import regenerate" -- ${cur}))
						;;
					'menu')
						COMPREPLY=($(compgen -W "create delete item list location" -- ${cur}))
						;;
					'network')
						COMPREPLY=($(compgen -W "meta" -- ${cur}))
						;;
					'option')
						COMPREPLY=($(compgen -W "add delete get list patch pluck update" -- ${cur}))
						;;
					'package')
						COMPREPLY=($(compgen -W "browse install list path uninstall update" -- ${cur}))
						;;
					'plugin')
						COMPREPLY=($(compgen -W "activate deactivate delete get install is-active is-installed list path search status toggle uninstall update verify-checksums" -- ${cur}))
						;;
					'post')
						COMPREPLY=($(compgen -W "create delete edit generate get list meta term update" -- ${cur}))
						;;
					'post-type')
						COMPREPLY=($(compgen -W "get list" -- ${cur}))
						;;
					'rewrite')
						COMPREPLY=($(compgen -W "flush list structure" -- ${cur}))
						;;
					'role')
						COMPREPLY=($(compgen -W "create delete exists list reset" -- ${cur}))
						;;
					'scaffold')
						COMPREPLY=($(compgen -W "_s block child-theme plugin plugin-tests post-type taxonomy theme-tests" -- ${cur}))
						;;
					#'search-replace')
					#	COMPREPLY=($(compgen -W "" -- ${cur}))
					#	;;
					#'server')
					#	COMPREPLY=($(compgen -W "" -- ${cur}))
					#	;;
					#'shell')
					#	COMPREPLY=($(compgen -W "" -- ${cur}))
					#	;;
					'sidebar')
						COMPREPLY=($(compgen -W "list" -- ${cur}))
						;;
					'site')
						COMPREPLY=($(compgen -W "activate archive create deactivate delete empty list mature meta option private public spam switch-language unarchive unmature unspam" -- ${cur}))
						;;
					'super-admin')
						COMPREPLY=($(compgen -W "add list remove" -- ${cur}))
						;;
					'taxonomy')
						case ${word3} in
							'get'|'list')
								COMPREPLY=();;
							*)
								COMPREPLY=($(compgen -W "get list" -- ${cur}))
								;;
						esac
						;;
					'term')
						COMPREPLY=($(compgen -W "create delete generate get list meta recount update" -- ${cur}))
						;;
					'theme')
						case ${word3} in
							"activate"|"delete"|"disable"|"enable"|"get"|"install"|"is-active"|"is-installed"|"list"|"mod"|"path"|"search"|"status"|"update")
								COMPREPLY=();;
							*)
								COMPREPLY=($(compgen -W "activate delete disable enable get install is-active is-installed list mod path search status update" -- ${cur}))
								;;
						esac
						;;
					'transient')
						case ${word3} in
							'delete'|'get'|'set'|'type')
								COMPREPLY=();;
							*)
								COMPREPLY=($(compgen -W "delete get set type" -- ${cur}))
								;;
						esac
						;;
					'user')
						COMPREPLY=($(compgen -W "add-cap add-role check-password create delete generate get import-csv list list-caps meta remove-cap remove-role reset-password session set-role spam term unspam update" -- ${cur}))
						;;
					'widget')
						case ${word3} in
							'add'|'deactivate'|'delete'|'list'|'move'|'reset'|'update')
								COMPREPLY=();;
							*)
								COMPREPLY=($(compgen -W "add deactivate delete list move reset update" -- ${cur}))
								;;
						esac
						;;
					*)
						COMPREPLY=($(compgen -W "${all_wp_commands}" -- ${cur}))
						;;
				esac
				;;
			'i18n')
				COMPREPLY=($(compgen -W "make-pot" -- ${cur}))
				;;
			#'import')
			#    COMPREPLY=($(compgen -W "" -- ${cur}))
			#    ;;
			'language')
				COMPREPLY=($(compgen -W "core plugin theme" -- ${cur}))
				;;
			'media')
				COMPREPLY=($(compgen -W "image-size import regenerate" -- ${cur}))
				;;
			'menu')
				COMPREPLY=($(compgen -W "create delete item list location" -- ${cur}))
				;;
			'network')
				COMPREPLY=($(compgen -W "meta" -- ${cur}))
				;;
			'option')
				COMPREPLY=($(compgen -W "add delete get list patch pluck update" -- ${cur}))
				;;
			'package')
				COMPREPLY=($(compgen -W "browse install list path uninstall update" -- ${cur}))
				;;
			'plugin')
				COMPREPLY=($(compgen -W "activate deactivate delete get install is-active is-installed list path search status toggle uninstall update verify-checksums" -- ${cur}))
				;;
			'post')
				case ${COMP_CWORD} in # ${COMP_CWORD} = word position
					2)
						COMPREPLY=($(compgen -W "create delete edit generate get list meta term update" -- ${cur}))
						;;
					3)
						case ${prev} in
							'create')
								# list of available options after 'post create'
								local post_create_options="--post_author=<post_author> --post_date=<post_date> --post_date_gmt=<post_date_gmt> --post_content=<post_content> --post_content_filtered=<post_content_filtered> --post_title=<post_title> --post_excerpt=<post_excerpt> --post_status=<post_status> --post_type=<post_type> --comment_status=<comment_status> --ping_status=<ping_status> --post_password=<post_password> --post_name=<post_name> --from-post=<post_id> --to_ping=<to_ping> --pinged=<pinged> --post_modified=<post_modified> --post_modified_gmt=<post_modified_gmt> --post_parent=<post_parent> --menu_order=<menu_order> --post_mime_type=<post_mime_type> --guid=<guid> --post_category=<post_category> --tags_input=<tags_input> --tax_input=<tax_input> --meta_input=<meta_input> --<field>=<value> --edit --porcelain --"
								COMPREPLY=($(compgen -W "${post_create_options}" -- ${cur}))
								;;
							'delete')
								COMPREPLY=($(compgen -W "<id> --force --defer-term-counting" -- ${cur}))
								;;
							'edit')
								COMPREPLY=($(compgen -W "" -- ${cur}))
								;;
							'generate')
								COMPREPLY=($(compgen -W "" -- ${cur}))
								;;
							'get')
								COMPREPLY=($(compgen -W "" -- ${cur}))
								;;
							'list')
								COMPREPLY=($(compgen -W "" -- ${cur}))
								;;
							'meta')
								COMPREPLY=($(compgen -W "" -- ${cur}))
								;;
							'term')
								COMPREPLY=($(compgen -W "" -- ${cur}))
								;;
							'update')
								COMPREPLY=($(compgen -W "" -- ${cur}))
								;;
						esac
						;;
				esac
				;;
			'post-type')
				COMPREPLY=($(compgen -W "get list" -- ${cur}))
				;;
			'rewrite')
				COMPREPLY=($(compgen -W "flush list structure" -- ${cur}))
				;;
			'role')
				COMPREPLY=($(compgen -W "create delete exists list reset" -- ${cur}))
				;;
			'scaffold')
				COMPREPLY=($(compgen -W "_s block child-theme plugin plugin-tests post-type taxonomy theme-tests" -- ${cur}))
				;;
			#'search-replace')
			#    COMPREPLY=($(compgen -W "" -- ${cur}))
			#    ;;
			'server')
				COMPREPLY=($(compgen -W "--host= --port= --docroot= --config=" -- ${cur}))
				;;
			'shell')
				if [[ ${word2} == "--basic" ]]
				then
					COMPREPLY=()
				else
					COMPREPLY=($(compgen -W "--basic" -- ${cur}))
				fi
				;;
			'sidebar')
				case ${word2} in
					'list')
						COMPREPLY=($(compgen -W "--fields=<fields> --format=<format>" -- ${cur}))
						;;
					*)
						COMPREPLY=($(compgen -W "list" -- ${cur}))
						;;
				esac
				;;
			'site')
				COMPREPLY=($(compgen -W "activate archive create deactivate delete empty list mature meta option private public spam switch-language unarchive unmature unspam" -- ${cur}))
				;;
			'super-admin')
				COMPREPLY=($(compgen -W "add list remove" -- ${cur}))
				;;
			'taxonomy')
				case ${word2} in
					'get'|'list')
						COMPREPLY=();;
					*)
						COMPREPLY=($(compgen -W "get list" -- ${cur}))
						;;
				esac
				;;
			'term')
				COMPREPLY=($(compgen -W "create delete generate get list meta recount update" -- ${cur}))
				;;
			'theme')
				COMPREPLY=($(compgen -W "activate delete disable enable get install is-active is-installed list mod path search status update" -- ${cur}))
				;;
			'transient')
				COMPREPLY=($(compgen -W "delete get set type" -- ${cur}))
				;;
			'user')
				COMPREPLY=($(compgen -W "add-cap add-role check-password create delete generate get import-csv list list-caps meta remove-cap remove-role reset-password session set-role spam term unspam update" -- ${cur}))
				;;
			'widget')
				case ${word2} in
					'add')
						COMPREPLY=($(compgen -W "<name> <sidebar-id> <position> --<field>=<value>" -- ${cur}))
						;;
					'deactivate')
						if [[ ${word3} = "<widget-id>" ]] # this isn't working... it's the angle brackets
						then
							COMPREPLY=()
						else
							COMPREPLY=($(compgen -W "<widget-id>" -- ${cur}))
						fi
						
#						case ${word3} in
#							"<widget-id>")
#								COMPREPLY=();;
#							*)
#								COMPREPLY=($(compgen -W "<widget-id>" -- ${cur}))
#								;;
#						esac
						;;
					'delete')
						COMPREPLY=($(compgen -W "<widget-id>" -- ${cur}))
						;;
					'list')
						COMPREPLY=($(compgen -W "<sidebar-id> [--fields=<fields>] --format=<format>" -- ${cur}))
						;;
					'move')
						COMPREPLY=($(compgen -W "<widget-id> --position=<position> --sidebar-id=<sidebar-id>" -- ${cur}))
						;;
					'reset')
						COMPREPLY=($(compgen -W "<sidebar-id> --all" -- ${cur}))
						;;
					'update')
						COMPREPLY=($(compgen -W "<sidebar-id> --<field>" -- ${cur}))
						;;
					*)
						COMPREPLY=($(compgen -W "add deactivate delete list move reset update" -- ${cur}))
						;;
				esac
				;;
			*)
				COMPREPLY=()
				;;
        esac
	fi
}

complete -F _wp_cli wp
