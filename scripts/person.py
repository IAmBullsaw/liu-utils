import json
import sys

def parse(arg):
    res = []
    if arg[0] == '-':
        res = parse_flag(arg[1:])
    return res

def parse_flag(flag):
    keys = []
    for c in flag:
        if c == 'm':
            keys.append('email_strict')
        elif c == 't':
            keys.append('phone_strict')
        elif c == 'i':
            keys.append('liu_id')
        elif c == 'n':
            keys.append('full_name_strict')
        else:
            raise Exception("Unknown flag {}".format(c))
    return keys

def main():
    keys=['full_name_strict', 'email_strict', 'liu_id', 'phone_strict']
    if len(sys.argv) > 1:
        keys = []
        for arg in sys.argv:
           keys += parse(arg)

    f = json.load(sys.stdin)
    for person in f['documentList']['documents']:
        for key in keys:
            try:
                tmp = person[key]
                print( tmp[0] if key == 'phone_strict' else tmp)
            except:
                continue

if __name__ == '__main__':
    main()
