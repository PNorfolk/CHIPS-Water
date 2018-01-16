###############################
##   Control Servos 1 & 2    ##
###############################

import Adafruit_BBIO.PWM as PWM
import Adafruit_BBIO.GPIO as GPIO
from time import sleep

#Set the BBB pins for the servos

servo1="P9_14"
servo2="P9_16"

#Set the duty cycles

s1o=3
s1c=10
s2o=2
s2c=10

#Set the delay required

delay=2

#Running the cycles

cycleNo=input("What cycle do you want to run? ")

while(1):
        # Let's start with the FILTRATION Cycle
        if cycleNo==0:
		print ('Filtration cycle activated')
                PWM.start(servo2,s2o,50)
                sleep(delay)
                PWM.start(servo1,s1c,50)
                cycleNo=input("What cycle do you want to run? ")
        # FILLING
        elif cycleNo==1:
                print ('Filling cycle activated')
                PWM.start(servo1,s1o,50)
                sleep(delay)
                PWM.start(servo2,s2c,50)
                cycleNo=input("What cycle do you want to run? ")
        # MEASUREMENTS
        elif cycleNo==2:
                print ('Measurement cycle activated')
                PWM.start(servo1,s1c,50)
                sleep(delay)
                PWM.start(servo2,s2c,50)
                cycleNo=input("What cycle do you want to run? ")
        # DRAINING
        else:
                print ('Draining cycle activated')
                PWM.start(servo1,s1c,50)
                sleep(delay)
                PWM.start(servo2,s2c,50)
                cycleNo=input("What cycle do you want to run? ")
