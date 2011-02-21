#!/bin/bash

stylus='Serial Wacom Tablet stylus'

# Find the line in "xrandr -q --verbose" output that contains current screen orientation and "strip" out current orientation. 

rotation="$(xrandr -q --verbose | grep 'connected' | egrep -o  '\) (normal|left|inverted|right) \(' | egrep -o '(normal|left|inverted|right)')" 

# Using current screen orientation proceed to rotate screen and input tools. 

case "$rotation" in 
    normal) 
#    -rotate to the left 
    xrandr -o left 
    xsetwacom set "$stylus" rotate CCW 
    ;; 
    left) 
#    -rotate to inverted 
    xrandr -o inverted 
    xsetwacom set "$stylus" rotate HALF 
    ;; 
    inverted) 
#    -rotate to the right 
    xrandr -o right 
    xsetwacom set "$stylus" rotate  CW 
    ;; 
    right) 
#    -rotate to normal 
    xrandr -o normal 
    xsetwacom set "$stylus" rotate NONE  
    ;; 
esac
