#! /bin/bash

function usage() {
    echo "usage: $0"
}

function help() {
    echo "Help for bash/liu-su-check-with-schema.sh"
    echo ""
    echo "DESCRIPTION
            Takes in '[free-seats] [SUxx]'' where xx is a number on each row
            It will then check with TimeEdit if the room is booked or not
            It returns data in format:
            '[free-seats] [SUxx] [true or false]'
            
            Recommended use with liu-su-fetch-free-spots.sh, see example"
    echo "USAGE
            `usage`"
    echo ""
    echo "OPTIONS
            -h Print this 'help'"
    echo ""
    echo "EXAMPLE
            echo '12 SU01' | ./liu-su-check-with-schema.s
            ./liu-su-fetch-free-spots.sh | ./liu-su-check-with-schema.sh"
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

# Check with schema
url='https://se.timeedit.net/web/liu/db1/schema/ri1q8XYX64ZZ01Qv6Y0X8956y6Y41565986Q899Q1Y79Y5889415X84X12Y9986589Y151X886764958Y894Y8489Y519918XX8956349456199XY84815865X4Y6Y998X1499769X918599547079ZYQl2QW86dlQ39mqX9bbW3joo%C3%A4c55qWXW46Q5aWZ6Zl6aKL2na01Xwod7nd8c57X9cFaWWVyom5ISyypad6yjar4X0anWjwWW6axcpvd5VXLc6mwVoru35rW5RbbVZuUYnXW9ojwX02c7cxom69WoQq7ZQQZZjuQooyyocZyqQo.txt'
schema=$(curl -L $url 2> /dev/null | tail -n +4)
while read line
do
    su=$(echo $line | cut -d' ' -f2)
    printf "$line "
    [[ $schema = *$su* ]] && printf "false\n" || printf "true\n"
done