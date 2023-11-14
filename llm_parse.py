#! /usr/bin/env python3

import re
import sys
import json

extensions = [
  '.txt',
  '.json', 'js',
  '.sh', '.bash',
  'Dockerfile',
  '.c', 'cpp', 'cxx', 'cc',
  '.h', '.hh', '.hpp',
  '.py',
  '.csv',
  '.md',
  '.rs', '.rb',
  '.lisp',
  'CMakeLists',
  'java',
  '.gitignore',
  '.css', '.html',
  '.sql',
  '.service',
  '.diff', '.patch'
]

def find_file_name(text):
    filename = None
    for tok in text.split(' '):
        for x in extensions:
            if tok.find(x) > 0:
                filename = tok.strip()
                filename = filename.replace('(', '' ).replace(')', '')
                filename = filename.replace('[', '' ).replace(']', '')
                filename = filename.replace('\\', '' )
                if filename[0] == '-':
                    filename = filename[1:]
    return filename

GREEN = '\033[32m'
BLUE = '\033[34m'
RED = "\033[31m"
RESET = "\033[0m"

def pp_block(name):
    print(f'{RED}-----{name}--------{RESET}')

def pp_code(nb, code):
    print(f'{GREEN}{nb:3}{RESET} {code}')

def process_markdown(file):
    def begin_block():
        blocks.append({
            'context':[],
            'name':
            f'file_{len(blocks)}.txt',
            'code':[]}
        )
        return False, 0

    blocks = []
    is_code, nb = begin_block()

    for i, line in enumerate(file, 1):

        if line.find("```") >= 0:
            if not is_code:
                # new code block
                is_code = True
                print('\n')
                pp_block(f' {blocks[-1]["name"]} ')
            else:
                # end of code block
                pp_block(f'------')
                is_code, nb = begin_block()
                print('\n')
        else:
            if not is_code:
                blocks[-1]['context'].append(line)
                name = find_file_name(line)
                if name:
                    blocks[-1]['name'] = name
            else:
               nb += 1
               blocks[-1]['code'].append(line)
            if is_code:
                pp_code(nb, line.rstrip())
            else:
                print(line.rstrip())
    return blocks


if __name__ == "__main__":

    f = sys.stdin
    # f = open(sys.argv[1],'r')
    blocks = process_markdown(f)
    with open('blocks.json', 'w') as f:
        json.dump(blocks, f, indent =2)


