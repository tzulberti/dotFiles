#!/usr/bin/env python

import os
import re
import subprocess
import sys

modified = re.compile('^(?:M|A)(\s+)(?P<name>.*)')

CHECKS = [
    {
        'output': 'Checking for pdbs...',
        'command': 'grep -n "import pdb" %s',
        'ignore_files': ['.*pre-commit'],
        'print_filename': True,
    },
    {
        'output': 'Checking for ipdbs...',
        'command': 'grep -n "import ipdb" %s',
        'ignore_files': ['.*pre-commit'],
        'print_filename': True,
    },
    {
        'output': 'Checking for redis pdb...',
        'command': 'grep -n "rdb.set_trace" %s',
        'ignore_files': ['.*pre-commit'],
        'print_filename': True,
    },
    # ahora los quecks para las cosas de JS
    {
        'output': 'Checking for console.log()...',
        'command': 'grep -n console.log %s',
        'match_files': ['.*yipit/.*\.js$'],
        'print_filename': True,
    },
    {
        'output': 'Checking for debugger...',
        'command': 'grep -n debugger %s',
        'match_files': ['.*yipit/.*\.js$'],
        'print_filename': True,
    },

]


def matches_file(file_name, match_files):
    return any(re.compile(match_file).match(file_name) for match_file in match_files)


def check_files(files, check, repo_root):
    result = 0
    for file_name in files:
        if not 'match_files' in check or matches_file(file_name, check['match_files']):
            if not 'ignore_files' in check or not matches_file(file_name, check['ignore_files']):
                process = subprocess.Popen(check['command'] % (repo_root + '/' + file_name), stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
                out, err = process.communicate()
                if out or err:
                    if check['print_filename']:
                        prefix = '\t%s:' % file_name
                    else:
                        prefix = '\t'
                    output_lines = ['%s%s' % (prefix, line) for line in out.splitlines()]
                    print '\n'.join(output_lines)
                    if err:
                        print err
                    result = 1
    return result


def main(all_files):
    p = subprocess.Popen(['git', 'rev-parse', '--show-toplevel'], stdout=subprocess.PIPE)
    out, _ = p.communicate()
    repo_root = out.splitlines()[0]
    
    files = []
    if all_files:
        for root, dirs, file_names in os.walk('.'):
            for file_name in file_names:
                files.append(os.path.join(root, file_name))
    else:
        p = subprocess.Popen(['git', 'status', '--porcelain'], stdout=subprocess.PIPE)
        out, err = p.communicate()
        for line in out.splitlines():
            match = modified.match(line)
            if match:
                files.append(match.group('name'))
    
    result = 0 
    for check in CHECKS:
        result = check_files(files, check, repo_root)
        if result:
            print 'Failed for check: %s' % check['output']
            break
    
    sys.exit(result)


if __name__ == '__main__':
    all_files = False
    if len(sys.argv) > 1 and sys.argv[1] == '--all-files':
        all_files = True
    main(all_files)
