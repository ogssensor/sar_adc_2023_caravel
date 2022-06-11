#!/bin/env wish
drc off
tech unlock *
snap internal
box values 0 0 0 0
set ifile [open fill_gen_info.txt r]
gets $ifile stepwidth
gets $ifile stepheight
gets $ifile xtiles
gets $ifile ytiles
gets $ifile xbase
gets $ifile ybase
close $ifile
cif ostyle wafflefill(tiled)
gds readonly true
gds rescale false
for {set y 0} {$y < $ytiles} {incr y} {
    for {set x 0} {$x < $xtiles} {incr x} {
        set xlo [expr $xbase + $x * $stepwidth]
        set ylo [expr $ybase + $y * $stepheight]
        set xhi [expr $xlo + $stepwidth]
        set yhi [expr $ylo + $stepheight]
        load caravel_0_fill_pattern_${x}_$y -quiet
        box values $xlo $ylo $xhi $yhi
        paint comment
        property FIXED_BBOX "$xlo $ylo $xhi $yhi"
        property GDS_FILE caravel_0_fill_pattern_${x}_${y}.gds
        property GDS_START 0
    }
}
load caravel_0_fill_pattern -quiet
for {set y 0} {$y < $ytiles} {incr y} {
    for {set x 0} {$x < $xtiles} {incr x} {
        box values 0 0 0 0
        getcell caravel_0_fill_pattern_${x}_$y child 0 0
    }
}
puts stdout "Writing final GDS"
cif *hier write disable
cif *array write disable
gds write ../gds/caravel_0_fill_pattern.gds
set endtime [orig_clock format [orig_clock seconds] -format "%D %T"]
puts stdout "Ended: $endtime"
quit -noprompt
