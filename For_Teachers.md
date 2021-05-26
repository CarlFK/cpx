The setup is optimized for answering the question "what is programming?"

Hook the CPX to a usb batery, hand it to the person, they inadvertently touch the touch pads, each  touch lights up an LED, it grabs their attention and they want to know what is going on and how.

Point at the micro controller chip, “This is running a Python program.  Let’s look at it.”  Unplug from the battery and plug into a laptop, get into the file manager, right click code.py, Edit.

Explain this code:
```
import time
from adafruit_circuitplayground.express import cpx

cpx.pixels.brightness = 0.3

while True:
    if cpx.touch_A1:
        print("Touched A1!")
        cpx.pixels[6] = (255, 0, 0)
```

Highlight the 2 import lines: “Time and cpx are libraries of code someone else wrote and this program will use.”

Move cursor to brightness “This dims the LEDs.  Full on is so bright it is annoying to look at.”

Move cursor to while True: “This is the event loop, a fancy way of saying Do this forever.”

Move cursor to if cpx.touch_A1: “Just like it reads, if you touch A1” point to the A1 touch pad (about 10 o-clock) 

Now they know what a program looks like and can tie words on the screen to the touch/led behavior.

“How do you turn them off?” is a good question.  Currently there is no code to turn them off, so lets write it.  

if cpx.button_a:
  cpx.pixels[6] = (0, 0, 0)

Now they see how easy it is to implement an idea.  

What happenes next is up to the student. 


# Setup the CPX

Use the latest stable version from:
https://github.com/adafruit/circuitpython/releases  currently 4.1.2
which is currently the default: 
`./cpx_setup.sh`
or to beta test: `./cpx_setup.sh 5.0.0-beta.5`
