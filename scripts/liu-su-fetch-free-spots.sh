#! /bin/bash
url='https://www.ida.liu.se/students/pul_free/index.sv.shtml'
seats=$(curl -L $url 2> /dev/null | awk -F"[><]+" '/SU[0-9]/{printf("%s %s\n", $4, $9)}' | sort -r -k1 -n)

printf "$seats" | while read line
do
    echo $line
done