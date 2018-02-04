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
            $0 -m 'marco kuhlman'"
    echo ""
}

### Functions

function search_mail() {
    url="https://search.liu.se/jellyfish/rest/apps/LiU/searchers/sitecore2_people_only?query=$@&lang=sv"
    awk -F"[:\"]" '/email_strict/{printf("%s\n", $5)}' <(curl -L $url 2> /dev/null)
}

### Main program flow

[ $# -gt 0 ] || { usage; exit -1; }

# Get options and call functions accordingly
while getopts ':m:h' flag; do
    case "${flag}" in
        m) 
            search_mail ${OPTARG} ;;
        h) help ;;
        *) { error "Unexpected option $(flag)"; exit -2; } ;;
    esac
done