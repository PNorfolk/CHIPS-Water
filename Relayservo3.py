##################################
#  Control the relay and servo3  #
##################################

import Adafruit_BBIO.PWM as PWM
import Adafruit_BBIO.GPIO as GPIO
from time import sleep

# Set which pins to use

servo3="P9_22"
relayfill="P8_11"
relaydrain="P8_9"

# Setting the duty cycle
s3o=2
s3c=10

# Setting up the Relays

GPIO.setup(relayFill, GPIO.OUT)
GPIO.setup(relayDrain, GPIO.OUT)

# Refer to ValveLogistics.odt for the settings I'll now set up

cycleNo=input("What cycle do you want to run? ")

while(1):
        # Let's start with the FILTRATION Cycle
        if cycleNo==0:
	            	print ('Filtration cycle activated')
                PWM.start(servo3,s3o,50)
                GPIO.output(relayFill, GPIO.HIGH)
                GPIO.output(relayDrain, GPIO.LOW)
                cycleNo=input("What cycle do you want to run? ")
        # FILLING
        elif cycleNo==1:
                print ('Filling cycle activated')
                PWM.start(servo3,s3c,50)
                GPIO.output(relayFill, GPIO.HIGH)
                GPIO.output(relayDrain, GPIO.LOW)
                cycleNo=input("What cycle do you want to run? ")
        # MEASUREMENTS
        elif cycleNo==2:
                print ('Measurement cycle activated')
                PWM.start(servo3,s3c,50)
                GPIO.output(relayFill, GPIO.HIGH)
                GPIO.output(relayDrain, GPIO.HIGH)
                cycleNo=input("What cycle do you want to run? ")
        # DRAINING
        else:
                print ('Draining cycle activated')
                PWM.start(servo3,s3o,50)
                GPIO.output(relayFill, GPIO.LOW)
                GPIO.output(relayDrain, GPIO.HIGH)
                cycleNo=input("What cycle do you want to run? ")




