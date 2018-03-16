import Adafruit_BBIO.GPIO as GPIO
#defining the GPIO pins
fill="P8_9"
drain="P8_15"
#Setting up the pins
GPIO.setup(fill, GPIO.OUT)
GPIO.setup(drain, GPIO.OUT)
#Setting the relay to turn both pumps off
GPIO.output(fill, GPIO.LOW)
GPIO.output(drain, GPIO.LOW)

print ("Both Pumps turned off. ")
