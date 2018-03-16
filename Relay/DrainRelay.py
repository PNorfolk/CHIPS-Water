### Turns on the Drain Pump ###

import Adafruit_BBIO.GPIO as GPIO #import necessary module

# Defining GPIO pins 
fill="P8_9"
drain="P8_15"
# Setting the relay to power the drain pump
GPIO.output(fill, GPIO.LOW)
GPIO.output(drain, GPIO.HIGH)
