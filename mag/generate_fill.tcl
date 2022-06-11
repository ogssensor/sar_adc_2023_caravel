#!/bin/env wish
drc off
tech unlock *
snap internal
box values 0 0 0 0
box size 700um 700um
set stepbox [box values]
set stepwidth [lindex $stepbox 2]
set stepheight [lindex $stepbox 3]

set starttime [orig_clock format [orig_clock seconds] -format "%D %T"]
puts stdout "Started: $starttime"

gds readonly true
gds rescale false
gds read ../gds/iadc
select top cell
expand

set fullbox [box values]
set xmax [lindex $fullbox 2]
set xmin [lindex $fullbox 0]
set fullwidth [expr {$xmax - $xmin}]
set xtiles [expr {int(ceil(($fullwidth + 0.0) / $stepwidth))}]
set ymax [lindex $fullbox 3]
set ymin [lindex $fullbox 1]
set fullheight [expr {$ymax - $ymin}]
set ytiles [expr {int(ceil(($fullheight + 0.0) / $stepheight))}]
box size $stepwidth $stepheight
set xbase [lindex $fullbox 0]
set ybase [lindex $fullbox 1]

for {set y 0} {$y < $ytiles} {incr y} {
    for {set x 0} {$x < $xtiles} {incr x} {
        set xlo [expr $xbase + $x * $stepwidth]
        set ylo [expr $ybase + $y * $stepheight]
        set xhi [expr $xlo + $stepwidth]
        set yhi [expr $ylo + $stepheight]
        if {$xhi > $fullwidth} {set xhi $fullwidth}
        if {$yhi > $fullheight} {set yhi $fullheight}
        box values $xlo $ylo $xhi $yhi
        box grow c 1.6um
        puts stdout "Flattening layout of tile x=$x y=$y. . . "
        flush stdout
        update idletasks
        flatten -dobox -nolabels caravel_0_fill_pattern_${x}_$y
        load caravel_0_fill_pattern_${x}_$y
        property GDS_FILE ""
        select top cell
        erase comment
        box values $xlo $ylo $xhi $yhi
        paint comment
        flush stdout
        update idletasks
        writeall force caravel_0_fill_pattern_${x}_$y
        load iadc
        cellname delete caravel_0_fill_pattern_${x}_$y
    }
}
set ofile [open fill_gen_info.txt w]
puts $ofile "$stepwidth"
puts $ofile "$stepheight"
puts $ofile "$xtiles"
puts $ofile "$ytiles"
puts $ofile "$xbase"
puts $ofile "$ybase"
close $ofile
quit -noprompt
