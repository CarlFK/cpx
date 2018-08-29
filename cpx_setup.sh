#!/bin/bash

# cpx_setup.sh
# sets up a circuitplayground_expres board with:
# circuitpython, a readme and nifty code.py

set -ex

cp \
    adafruit-circuitpython-circuitplayground_express-3.0.1.uf2 \
    /media/carl/CPLAYBOOT$1
sync
sleep 10

cp \
    ~/src/cpx/readme_cpx.txt \
    /media/carl/CIRCUITPY/readme.txt

cp \
    ~/src/Welcome_to_CircuitPython_CPX/cpx_touch_pixel_rainbow.py \
    /media/carl/CIRCUITPY/code.py
