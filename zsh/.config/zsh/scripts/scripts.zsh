mkcd() {
    local dir="$*";
    local mkdir -p "$dir" && cd "$dir";
}

mnt() {
    local FILE="/mnt/external"
    if [ ! -z $2 ]; then
        FILE=$2
    fi

    if [ ! -z $1 ]; then
        sudo mount "$1" "$FILE" -o rw
        echo "Device in read/write mounted in $FILE"
    fi

    if [ $# = 0 ]; then
        echo "You need to provide the device (/dev/sd*) - use lsblk"
    fi
}

umnt() {
    local DIRECTORY="/mnt"
    if [ ! -z $1 ]; then
        DIRECTORY=$1
    fi
    MOUNTED=$(grep $DIRECTORY /proc/mounts | cut -f2 -d" " | sort -r)
    cd "/mnt"
    sudo umount $MOUNTED
    echo "$MOUNTED unmounted"
}

-echo() {
    "$@" &> /dev/null & disown
}

# +--------+
# | Ranger |
# +--------+
rr() {
    if [ -n "$RANGER_LEVEL" ]; then exit
    fi
    if [ "$1" != "" ]; then
        if [ -d "$1" ]; then
            ranger "$1"
        else
            ranger "$(zoxide query $1)"
        fi
    else
        ranger
    fi
    return $?
}

r() {
    if [ -n "$RANGER_LEVEL" ]; then exit
    fi
    temp_file="$(mktemp -t "ranger_cd.XXXXXXXXXX")"
    if [ "$1" != "" ]; then
        if [ -d "$1" ]; then
            ranger --choosedir="$temp_file" -- "$1"
        else
            ranger --choosedir="$temp_file" -- "$(zoxide query $1)"
        fi
    else
        ranger --choosedir="$temp_file" -- "${@:-$PWD}"
    fi
    if chosen_dir="$(cat -- "$temp_file")" && [ -n "$chosen_dir" ] && [ "$chosen_dir" != "$PWD" ]; then
        cd -- "$chosen_dir"
    fi
    rm -f -- "$temp_file" > /dev/null
    return $?
}

# Key-bindings
# bindkey -s '^@' 'ranger^M'