# color_look_see.py
    
# Simple demo of the TCS34725 color sensor.
# Will detect the color from the sensor.
import time

import board
import busio

import adafruit_tcs34725

from adafruit_circuitplayground.express import cpx

# Initialize I2C bus and sensor.
i2c = busio.I2C(board.SCL, board.SDA)
sensor = adafruit_tcs34725.TCS34725(i2c)

cpx.pixels.brightness = 0.1

# Main loop reading color and printing it every second.
while True:
    # Read the color as RGB bytes (0-255 values).
    r, g, b = sensor.color_rgb_bytes
    # print('Detected color: #{0:02X} {1:02X} {2:02X}'.format(r, g, b))
    
    # Read the color temperature and lux of the sensor too.
    try:
        temp = sensor.temperature
        lux = sensor.lux
        # print('Temperature: {0}K Lux: {1}'.format(temp, lux))
    except ZeroDivisionError:
        print("No light to measure")

    r = max(0,r-29)
    g = max(0,g-24)
    b = max(0,b-4)
    print((b,g,r),)
    
    # light up all the neopixels to the rgb values
    cpx.pixels.fill((r, g, b))

    # Delay for a second and repeat.
    time.sleep(1.0)
    