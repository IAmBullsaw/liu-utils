import json
import sys
import argparse
import urllib.request
from html.parser import HTMLParser

def get_arguments():
    parser = argparse.ArgumentParser(description='Search for persons at LiU more easily')
    parser.add_argument('-c','--count', nargs='?', type=int, help='how many matches to show')
    parser.add_argument('-m','--mail', action='store_true', help='print mail')
    parser.add_argument('-t','--tele', action='store_true', help='print telephone number')
    parser.add_argument('-n','--name', action='store_true', help='print name')
    parser.add_argument('-l','--liuid', action='store_true', help='print LiUid')
    parser.add_argument('-r','--room', action='store_true', help='print room')
    parser.add_argument('names', nargs='+', help='the names to search LiU for')
    return parser.parse_args()

def get_keys(args):
    keys = []
    if args.mail:
        keys.append('email_strict')
    if args.tele:
        keys.append('phone_strict')
    if args.name:
        keys.append('full_name_strict')
    if args.room:
        keys.append('room')
    if args.liuid:
        keys.append('liu_id')
    return keys if len(keys) > 0 else ['full_name_strict', 'email_strict', 'phone_strict', 'liu_id', 'room']

def get_count(args):
    return args.count if args.count else 100

def get_request(args):
    return urllib.request.Request("https://search.liu.se/jellyfish/rest/apps/LiU/searchers/sitecore2_people_only?query={}&lang=sv".format('+'.join(args.names)))

def is_exact_match(name, names):
    return name.lower() == ' '.join(names).lower()


# Relates only to get_room()
class MyHTMLParser(HTMLParser):
    read = 0
    data_found = []
    def handle_data(self, data):
        if 'Besöksadress' == data:
            self.read = 5
        if self.read > 0:
            self.data_found.append(data)
            self.read -= 1

def get_room(liuid):
    parser = MyHTMLParser()
    req = urllib.request.Request("https://liu.se/medarbetare/{}".format(liuid))
    data = []
    with urllib.request.urlopen(req) as f:
        body = f.read()
        parser.feed(body.decode('utf-8'))
        for entry in parser.data_found:
            if not entry.find('\r\n',0,2) or entry == 'Besöksadress':
                continue
            else:
                data.append(entry)
    parser.data_found.clear()
    return data

def main():
    args = get_arguments()
    keys = get_keys(args)
    results = get_count(args)
    req = get_request(args)

    f = None
    with urllib.request.urlopen(req) as request:
        body = request.read()
        f = json.loads(body.decode('utf-8'))

        for person in f['documentList']['documents']:
            results -= 1
            if results < 0:
                break
            for key in keys:
                if key == 'room':
                    print(get_room(person['liu_id']))
                try:
                    tmp = person[key]
                    print(tmp[0] if key == 'phone_strict' else tmp)
                except:
                    continue
            if is_exact_match(person['full_name_strict'], args.names):
                break

if __name__ == '__main__':
    main()
