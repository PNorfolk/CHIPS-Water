### Turns on the Fill Pump ###

import Adafruit_BBIO.GPIO as GPIO #importing necessary module
#Defining GPIO pins
fill="P8_9"
drain="P8_15"
#Setting the relay to power the Fill pump
GPIO.output(fill, GPIO.HIGH)
GPIO.output(drain, GPIO.LOW)
