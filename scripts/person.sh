#! /bin/bash

function usage() {
    echo -e "usage:\n$0 [-flags] name\nname could be Sven or sven Svensson"
}

[ $# -gt 0 ] || { usage; exit -1; }

### Functions

function mail() {
    echo "mail"
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
URL="https://search.liu.se/jellyfish/rest/apps/LiU/searchers/sitecore2_people_only?query=$NAME+$SURNAME&lang=sv"
RES=`curl -L $URL`






# present info
for command in ${commandarray[@]}
do
    $command
done
