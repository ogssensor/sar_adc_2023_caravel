#!/bin/env wish
drc off
tech unlock *
snap internal
box values 0 0 0 0
set filename [file root [lindex $argv $argc-1]]
load $filename
cif ostyle wafflefill(tiled)
gds write [file root $filename].gds
quit -noprompt
