import time

from adafruit_circuitplayground.express import cpx
import board
from analogio import AnalogIn

cpx.pixels.brightness = 0.1

bpm_range = [40,220]

analog_in = AnalogIn(board.A1)

pot_low = 2500 # or 24xx
pot_high = 65520  #65520 on the money.

pot_range = pot_high - pot_low

light_no = 0

while True:

    # figure out how long a beat is
    pot = analog_in.value
    # print((pot,))
    p = (pot-pot_low)/pot_range
    p = min(max(p,0),1)

    bpm = bpm_range[0] + p * (bpm_range[1]-bpm_range[0])
    print((bpm,))
    
    # work out when the next beat is - now + 1 beat.
    now = time.monotonic()
    next_beat = now + 60/bpm

    # thing that takes some time:
    # turn off the current light, bump, turn on next light, beep
    cpx.pixels[light_no] = (0, 0, 0)
    light_no =  (light_no + 1) % 4
    cpx.pixels[light_no] = (0, 255, 0)
    cpx.play_tone(320, .1)


    # wait for the beat
    sleep_time = next_beat - time.monotonic()
    time.sleep(sleep_time)
