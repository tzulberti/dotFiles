#!/usr/bin/env python

"""
Author: Saophalkun Ponlu (http://phalkunz.com)
Contact: phalkunz@gmail.com
Date: May 23, 2009
Modified: June 15, 2009

Additional modifications:
Author: Phil Christensen (http://bubblehouse.org)
Contact: phil@bubblehouse.org
Date: February 22, 2010

Requiere de colorama
"""

from colorama import init, Fore, Back, Style
import sys, re, subprocess

init()

tabsize = 4

colorizedSubcommands = (
    'st',
    'status',
    'add',
    'remove',
    'diff',
)

statusColors = {
    "M" : Fore.RED, # red
    "\?" : Fore.BLUE, # grey
    "A" : Fore.GREEN, # green
    "X" : Fore.YELLOW, # yellow
    "C" : Back.BLACK + Fore.RED , # black on red
    "-" : Fore.RED, # red
    "D" : Style.DIM + Fore.RED, # bold red
    "\+" : Fore.GREEN, # green
    "!": Fore.CYAN,
}






def colorize(line):
    for color in statusColors:
        if re.match(color, line):
            print statusColors[color] + line + Fore.RESET + Back.RESET + Style.RESET_ALL
            return
    else:
        print line

def escape(s):
    s = s.replace('$', r'\$')
    s = s.replace('"', r'\"')
    s = s.replace('`', r'\`')
    return s



passthru = lambda x: x
quoted = lambda x: '"%s"' % escape(x)

if __name__ == "__main__":
    cmd = ' '.join(['svn']+[(passthru, quoted)[' ' in arg](arg) for arg in sys.argv[1:]])
    output = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
    cancelled = False
    lines = output.stdout.readlines()
    if sys.argv[1] not in ('diff'):
        lines.sort()
    for line in lines:
        line = line.expandtabs(tabsize)
        line = line.rstrip()
        if (sys.argv[1] in colorizedSubcommands):
            line = colorize(line)
        else:
            print line

