import json
import sys
import argparse
import urllib.request



def main():
    parser = argparse.ArgumentParser(description='Search for persons at LiU more easily')
    parser.add_argument('-m','--mail', help='print mail to stdout')
    parser.add_argument('-t','--tele', help='print telephone number to stdout')
    parser.add_argument('-n','--name', help='print name to stdout')
    parser.add_argument('names', nargs='+', help='the names to search LiU for')
    args = parser.parse_args()
    print(args.names)
    url="https://search.liu.se/jellyfish/rest/apps/LiU/searchers/sitecore2_people_only?query=marco&lang=sv"
    f = None
    with urllib.request.urlopen(url) as request:
        body = request.read()
        f = json.loads(body.decode('utf-8'))

        for person in f['documentList']['documents']:
            try:
                tmp = person[key]
                print( tmp[0] if key == 'phone_strict' else tmp)
            except:
                continue

if __name__ == '__main__':
    main()
