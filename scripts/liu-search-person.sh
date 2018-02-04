#! /bin/bash

function usage() {
    echo -e "usage:\n$0 [-flags] name\nExample '$0 [-flags] marco kuhlman'"
}

function help() {
    echo "Help for bash/liu-search-person.sh"
    echo ""
    echo "DESCRIPTION
            Fetches given parameters by searching the web with the persons name"
    echo "USAGE
            `usage`"
    echo ""
    echo "OPTIONS
            -h Print this 'help'
            -m Print email"
    echo ""
    echo "EXAMPLE
            $0 -m 'marco kuhlman'
            $0 -mt 'marco'"
    echo ""
}

### Functions

function search() {
    regex=$1
    shift
    searchterm=$@
    url="https://search.liu.se/jellyfish/rest/apps/LiU/searchers/sitecore2_people_only?query=$searchterm&lang=sv"
    awk -F"[:\"]" '/'"$regex"'/{printf("%s\n", $5)}' <(curl -L $url 2> /dev/null)
}

### Main program flow

[ $# -gt 0 ] || { usage; exit -1; }

# Get options and call functions accordingly
regex=''
while getopts 'mht' flag; do
    case "${flag}" in
        h) HELP=true ;;
        m) regex+='email_strict|';;
        t) regex+='phone_strict|';;
        *) { error "Unexpected option $(flag)"; exit -2; } ;;
    esac
done
shift $((OPTIND-1)) # Eat options!

# Print help
if [ $HELP ]; then
    help;
    exit 0;
fi

searchterm=$@
search ${regex::-1} $searchterm