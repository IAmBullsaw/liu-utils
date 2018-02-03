#! /bin/bash

function usage() {
    echo -e "usage:\n$0 [-flags] name\nname could be Sven or sven Svensson"
}

[ $# -gt 0 ] || { usage; exit -1; }

### Functions

function mail() {
    KEYS=$1
    VALS=$2
    keymail=email_strict
    END=${#KEYS[@]}
    for ((i=0;i<=END;i++)); do
        key=${KEYS[i]}
        val=${VALS[i]}

        if [ "$key" == "$keymail" ]; then
            echo $val;
            break;
        fi

    done
}

function tele() {
    echo "tele"
}

function room() {
    echo "room"
}

function liuid() {
    echo "liuid"
}

### Main program flow

commandarray=()
while getopts 'mtri' flag; do
    case "${flag}" in
        m) commandarray+=(mail) ;;
        t) commandarray+=(tele) ;;
        r) commandarray+=(room) ;;
        i) commandarray+=(liuid) ;;
        *) { error "Unexpected option $(flag)"; exit -2; } ;;
    esac
done
shift $((OPTIND-1)) # Eat options!

# Get who
NAME="$1"
SURNAME="$2"

# perform request
url="https://search.liu.se/jellyfish/rest/apps/LiU/searchers/sitecore2_people_only?query=$NAME+$SURNAME&lang=sv"
#RES=$(curl -sL $URL)

KEYS=()
VALS=()

while read line; do
    # row=$(echo $line | grep 'strict')
    if [[ ${#line} -ge 4 ]]; then
        key=$(echo $line | cut -d':' -f1)
        key=$(echo ${key:1:-2})
        value=$(echo $line | cut -d':' -f2)
        KEYS+=($key)
        VALS+=($value)
    fi
done < <(curl -sL $url /dev/null)

# present info
for command in ${commandarray[@]}
do
    $command $KEYS $VALS
done
