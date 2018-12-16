#!/bin/bash

# cpx_setup.sh
# sets up a circuitplayground_expres board with:
# circuitpython, a readme and nifty code.py

set -ex

target=/media/$USER
assets=~/sbc/cpx

img=adafruit-circuitpython-circuitplayground_express-3.1.1.uf2

if [ ! -f ${assets}/${img} ]; then
  wget -N --directory-prefix ${assets}  \
    https://github.com/adafruit/circuitpython/releases/download/3.1.1/${img}
fi

echo Plug it in, hit the reset once or twice till all the leds are green.

while [ ! -d ${target}/CPLAYBOOT ]; do
    sleep 1
done

cp ${assets}/${img} ${target}/CPLAYBOOT
sync
sleep 15

cp README.md ${target}/CIRCUITPY/

cp workshop_starter.py ${target}/CIRCUITPY/code.py
cp ~/src/PS1_2018/??_cpx_*.py ${target}/CIRCUITPY/
cp ~/src/PS1_2018/README.md ${target}/CIRCUITPY/
cp ~/src/PS1_2018/LICENSE ${target}/CIRCUITPY/

sync
pumount /dev/sdc1
eject /dev/sdc

