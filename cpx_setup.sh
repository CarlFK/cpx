#!/bin/bash

# cpx_setup.sh
# sets up a circuitplayground_expres board with:
# circuitpython, a readme and nifty code.py

# latest: https://circuitpython.org/board/circuitplayground_express/

# alpha: adafruit-circuitpython-circuitplayground_express-en_US-11.0.0-alpha.3.uf2
# example ./cpx_setup.sh 11.0.0-alpha.3

set -ex

cp_ver=${1:-10.3.1}

# target=/media/$USER
target=/run/media/$USER
assets=~/sbc/cpx

dl_root=https://downloads.circuitpython.org/bin/circuitplayground_express/en_US

img=adafruit-circuitpython-circuitplayground_express-en_US-${cp_ver}.uf2

if (pgrep fwupd); then
    echo fwupd messes up things..
    sudo pkill fwupd
fi

if [ ! -f ${assets}/${img} ]; then
  wget -N --directory-prefix ${assets}  \
    ${dl_root}/${img}
fi

if [ ! -d ${assets}/Welcome_to_CircuitPython_CPX ]; then
    git clone https://github.com/kattni/Welcome_to_CircuitPython_CPX \
        ${assets}/Welcome_to_CircuitPython_CPX
fi


while [ ! -d ${target}/CPLAYBOOT ]; do
  echo Plug it in, hit the reset once or twice till all the leds are green.
  sleep 1
done

echo https://circuitpython.org/board/circuitplayground_express/
echo https://github.com/adafruit/uf2-samdx1/releases/download/v4.0.0/update-bootloader-circuitplay_m0-v4.0.0.uf2
echo ~/sbc/cpx/update-bootloader-circuitplay_m0-v4.0.0.uf2

echo bossac -e -w -v -b  --offset=0x2000 ~/sbc/cpx/update-bootloader-circuitplay_m0-v4.0.0.uf2 --reset

cp ${assets}/${img} ${target}/CPLAYBOOT
echo waiting for OS to mount ${target}/CIRCUITPY/
sync
while [ ! -d ${target}/CIRCUITPY/ ]; do
  sleep 2
done

# rm ${target}/CIRCUITPY/* -rf

cp \
    README.md \
    ${target}/CIRCUITPY/

cp \
    ${assets}/Welcome_to_CircuitPython_CPX/cpx_touch_pixel_rainbow.py \
    ${target}/CIRCUITPY/code.py

rm -rf /${target}/CIRCUITPY/Welcome_to_CircuitPython_CPX
rsync -rtvP --cvs-exclude \
    ${assets}/Welcome_to_CircuitPython_CPX \
    ${target}/CIRCUITPY/

sync

dev=$(findfs LABEL=CIRCUITPY)
# pumount ${target}/CIRCUITPY/
eject ${dev}

