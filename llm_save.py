#! /usr/bin/env python3

import sys
import json


if __name__ == "__main__":

    # read the blocks in the file
    with open(sys.argv[1],'r') as f:
        blocks = json.load(f)

    for block in blocks:
        name = block["name"]
        context = "".join(block["context"])
        text = "".join(block["code"])
        if not text:
            continue
        while True:
            print('[S]ave [R]ename [D]elete [V]iew [C]ontext:')
            cmd = input(f'{name}? ').lower()
            if cmd == 's':
                with open(name, 'w') as f:
                    f.write(text)
                print(f'saved to {name}')
                break
            elif cmd == 'r':
                name = input("Enter the new file name: ")
            elif cmd == 'd':
                break
            elif cmd == 'v':
                print(f'\n{text}\n')
            elif cmd == 'c':
                print(f'\n{context}\n')
            else:
                print('?')

