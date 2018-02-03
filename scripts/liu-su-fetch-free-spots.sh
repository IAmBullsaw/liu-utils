#! /bin/bash

function usage() {
    echo "usage: $0"
}

function help() {
    echo "Help for bash/liu-su-check-with-schema.sh"
    echo ""
    echo "DESCRIPTION
            Fetches SUxx and its currently free seats, will return data in
            format: [free-seats] [SUxx]
            Where xx is a number. Will also sort it in decreasing order on
            free seats available.
            
            Recommended use with liu-su-check-with-schema.sh"
    echo "USAGE
            `usage`"
    echo ""
    echo "OPTIONS
            -h Print this 'help'"
    echo ""
    echo "EXAMPLE
            ./liu-su-fetch-free-spots.sh"
    echo ""
}

##################
# MAIN SCRIPT FLOW

# Get options
while getopts 'h' flag; do
    case "${flag}" in
        h) HELP=true ;;
        *) { error "Unexpected option $(flag)"; exit -1; } ;;
    esac
done

# Print help
if [ $HELP ]; then
    help;
    exit 0;
fi

url='https://www.ida.liu.se/students/pul_free/index.sv.shtml'
seats=$(curl -L $url 2> /dev/null | awk -F"[><]+" '/SU[0-9]/{printf("%s %s\n", $4, $9)}' | sort -r -k1 -n)

printf "$seats" | while read line
do
    echo $line
done