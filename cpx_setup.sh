#!/bin/bash

# cpx_setup.sh
# sets up a circuitplayground_expres board with:
# circuitpython, a readme and nifty code.py

set -ex

target=/media/$USER

cp \
    adafruit-circuitpython-circuitplayground_express-3.0.1.uf2 \
    ${target}/CPLAYBOOT$1
sync
sleep 15

cp \
    ~/src/cpx/README.md \
    ${target}/CIRCUITPY/

cp \
    ~/src/Welcome_to_CircuitPython_CPX/cpx_touch_pixel_rainbow.py \
    ${target}/CIRCUITPY/code.py
