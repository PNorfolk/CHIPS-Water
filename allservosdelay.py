##############################################
#  --Controls all the servos and relays--    #
#   includes delays between turning valves   #
#    to keep the current low                 #
###############################################

# Turn servos for different configurations
# servo1: pin14
# servo2: pin16
# servo3: pin22

import Adafruit_BBIO.PWM as PWM
import Adafruit_BBIO.GPIO as GPIO
from time import sleep

# Set which pins we'll use

servo1="P9_14"
servo2="P9_22"
servo3="P9_42"
relayFill="P8_11"
relayDrain="P8_9"

# Set the duty cycles required to open(o) and close(c) each servo valve

s1o=3
s1c=8.6
s2o=8.6
s2c=3
s3o=3
s3c=8.6

#Setting the delay between valves closing, to ensure current is kept low

delay=2

# Setting up the Relays

GPIO.setup(relayFill, GPIO.OUT)
GPIO.setup(relayDrain, GPIO.OUT)

# Refer to ValveLogistics.odt for the settings I'll now set up

cycleNo=input("What cycle do you want to run? ")

while(1):
        # Let's start with the FILTRATION Cycle
        if cycleNo==0:
		print ('Filtration cycle activated')
                PWM.start(servo2,s2o,50)
                sleep(delay)
                PWM.start(servo1,s1c,50)
                sleep(delay)
                PWM.start(servo3,s3o,50)
                GPIO.output(relayFill, GPIO.HIGH)
                GPIO.output(relayDrain, GPIO.LOW)
                cycleNo=input("What cycle do you want to run? ")
        # FILLING
        elif cycleNo==1:
                print ('Filling cycle activated')
                PWM.start(servo1,s1o,50)
                sleep(delay)
                PWM.start(servo2,s2c,50)
                sleep(delay)
                PWM.start(servo3,s3c,50)
                GPIO.output(relayFill, GPIO.HIGH)
                GPIO.output(relayDrain, GPIO.LOW)
                cycleNo=input("What cycle do you want to run? ")
        # MEASUREMENTS
        elif cycleNo==2:
                print ('Measurement cycle activated')
                PWM.start(servo1,s1c,50)
                sleep(delay)
                PWM.start(servo2,s2c,50)
                sleep(delay)
                PWM.start(servo3,s3c,50)
                GPIO.output(relayFill, GPIO.HIGH)
                GPIO.output(relayDrain, GPIO.HIGH)
                cycleNo=input("What cycle do you want to run? ")
        # DRAINING
        else:
                print ('Draining cycle activated')
                PWM.start(servo3,s3o,50)
                sleep(delay)
                PWM.start(servo1,s1c,50)
                sleep(delay)
                PWM.start(servo2,s2c,50)
                GPIO.output(relayFill, GPIO.LOW)
                GPIO.output(relayDrain, GPIO.HIGH)
                cycleNo=input("What cycle do you want to run? ")

 
