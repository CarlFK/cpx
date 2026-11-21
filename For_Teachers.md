# Point
 The setup is optimized for answering questions like "What is programming?" or "Can you teach me Python?"

## Sikp the Boring Stuff 
Using Circuit Python on the CPX lets us skip the boring stuff: "How much do you know already?" then spending 30+ min installing Python and talking about OS paths and dependency management and best practices like version control of your countless (one) project directory and all the other boring stuff.

Skip over all that and go right to something engaging: Blinking lights.

## Fun Stuff
Hook the CPX to a usb battery, hand it to the person who will inadvertently touch the touch pads lighting up the LED it grabs their attention and they want to know what is going on and how.

Point at the micro controller chip, “This is running a Python program.  Let’s look at it.”  Unplug from the battery and plug into a laptop, get into the file manager, right click code.py, Edit.

## Teaching
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

What happens next is up to the student's ambition.

# Setup the CPX
see INSTALL.md
