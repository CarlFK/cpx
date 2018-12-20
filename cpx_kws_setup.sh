#!/bin/bash

# cpx_kws_setup.sh
# setup for Kattni Workshop
# sets up a circuitplayground_express board with:
# circuitpython, all the files from github.com/kattni/PS1_2018.git

set -ex

target=/media/$USER
assets=~/sbc/cpx

img=adafruit-circuitpython-circuitplayground_express-3.1.1.uf2
repo_url=https://github.com/kattni/PS1_2018.git
repo_name=PS1_2018

if [ ! -f ${assets}/${img} ]; then
  wget -N --directory-prefix ${assets}  \
    https://github.com/adafruit/circuitpython/releases/download/3.1.1/${img}
fi

if [ ! -d ${assets}/${repo_name} ]; then
    git clone ${repo_url} ${assets}/${repo_name}
fi

while [ ! -d ${target}/CPLAYBOOT ]; do
    echo Plug it in, hit the reset once or twice till all the leds are green.
    sleep 1
done

cp ${assets}/${img} ${target}/CPLAYBOOT
sync
sleep 5

while [ ! -d ${target}/CIRCUITPY ]; do
    echo waitting for board to reset and os to mount CIRCUITPY
    sleep 1
done

# copy just the files in the root, no dirs, no .git/
cp -v ${assets}/${repo_name}/*.py ${target}/CIRCUITPY/
cp -v ${assets}/${repo_name}/README.md ${target}/CIRCUITPY/
cp -v ${assets}/${repo_name}/LICENSE ${target}/CIRCUITPY/

# alert that we are about done.
cp ${assets}/${repo_name}/07_cpx_play_tone.py ${target}/CIRCUITPY/code.py
sync
sleep 3
cp workshop_starter.py ${target}/CIRCUITPY/code.py

sync
pumount /dev/sdc1
eject /dev/sdc

echo Done.
