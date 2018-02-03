#! /bin/bash


while getopts 'oj' flag; do
    case "${flag}" in
        o) OSKAR=true ;;
        j) JOHAN=true ;;
        *) { error "Unexpected option $(flag)"; exit -1; } ;;
    esac
done



[ $JOHAN ] && {
    s=$(curl -L https://se.timeedit.net/.../ri1q8XYX64ZZ01Qv6Y0X8956y6Y41... 2> /dev/null | tail -n +4);printf "$(curl -L https://www.ida.liu.se/students/pul_free/index.sv.shtml 2> /dev/null | awk -F"[><]+" '/SU[0-9]/{printf("%s %s\n", $4, $9)}' | sort -r -k1 -n)" | while read l;do n=$(echo $l | cut -d' ' -f2);p=$(echo $l | cut -d' ' -f1);[[ $s = *$n* ]] && printf "F" || printf "T";printf " $n $p\n";done
    exit 0;
}
[ $OSKAR ] && {
    # First we create the python3 script
    echo -e "import re\n
import sys\n
\n
re_free = '>(\d+)<'\n
re_name = '>(\w{2}\d+)<'\n
\n
def main():\n
    rooms = []\n
    for line in sys.stdin:\n
        free = re.search(re_free, line).group(1)\n
        name = re.search(re_name, line).group(1)\n
        rooms.append((int(free), name))\n
    print('Top three rooms:')\n
    for room in reversed(sorted(rooms)[len(rooms)-3:]):\n
        print(room[1],room[0])\n
\n
if __name__ == '__main__':\n
    main()\n
" > coolscript1337.py
    # Then we do the thing
    curl https://www.ida.liu.se/students/pul_free/index.sv.shtml 2> /dev/null | grep "<tr><td>" 1> allrooms1337.txt && python3 coolscript1337.py < allrooms1337.txt && rm allrooms1337.txt && rm coolscript1337.py
}
