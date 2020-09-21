
#
# Create a new directory and cd into it at the same time.
#
mkdircd ()
{
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}

# Redefine `cd` to a function so that when a dir/file
# path is passed as an argument, it will cd to the
# directory containing that file. Otherwise, it's unchanged.
#
# Ref: <https://unix.stackexchange.com/questions/76227/how-to-make-cd-dir-filename-take-me-to-dir>

cd() {
    local file="${!#}"

    if (( "$#" )) && ! [[ -d "$file" ]]; then
        builtin cd "${@:1:($#-1)}" "${file%/*}"
    else
        builtin cd "$@"
    fi
}
