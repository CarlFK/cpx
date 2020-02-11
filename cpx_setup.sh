#!/bin/bash

# cpx_setup.sh
# sets up a circuitplayground_expres board with:
# circuitpython, a readme and nifty code.py

set -ex

target=/media/$USER
assets=~/sbc/cpx

cp_ver=5.0.0-beta.5
# cp_ver=4.1.2
img=adafruit-circuitpython-circuitplayground_express-en_US-${cp_ver}.uf2

if [ ! -f ${assets}/${img} ]; then
  wget -N --directory-prefix ${assets}  \
    https://github.com/adafruit/circuitpython/releases/download/${cp_ver}/${img}
fi

if [ ! -d ${assets}/Welcome_to_CircuitPython_CPX ]; then
    git clone https://github.com/kattni/Welcome_to_CircuitPython_CPX \
        ${assets}/Welcome_to_CircuitPython_CPX
fi


while [ ! -d ${target}/CPLAYBOOT ]; do
  echo Plug it in, hit the reset once or twice till all the leds are green.
  sleep 1
done

cp ${assets}/${img} ${target}/CPLAYBOOT
sync
sleep 5 # wait for os to see CIRCUITPY drive

# rm ${target}/CIRCUITPY/* -rf

cp \
    README.md \
    ${target}/CIRCUITPY/

cp \
    ~/src/Welcome_to_CircuitPython_CPX/cpx_touch_pixel_rainbow.py \
    ${target}/CIRCUITPY/code.py

cp -a \
    ${assets}/Welcome_to_CircuitPython_CPX \
    ${target}/CIRCUITPY/

sync
pumount /dev/sdc1
eject /dev/sdc
