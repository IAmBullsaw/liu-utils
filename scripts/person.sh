#! /bin/bash

function usage() {
    echo -e "usage:\n$0 [-flags] name\nname could be Sven or sven Svensson"
}

[ $# -gt 0 ] || { usage; exit 0; }

WHO="$1"
URL="https://search.liu.se/jellyfish/rest/apps/LiU/searchers/sitecore2_people_only?query=$WHO&lang=sv"
OUT=test.json
curl -o "$OUT" "$URL"
