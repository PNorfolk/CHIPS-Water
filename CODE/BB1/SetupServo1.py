###############################
#      Sets up servo 1       #
#   before running maincode   # 
###############################

import Adafruit_BBIO.PWM as PWM
from time import sleep

# The pins we'll use
servo1="P9_14"

#Setting up servo 1:
print ("Setting up servo 1: Setting duty cycle at 8.6.")
PWM.start(servo1,8.6,50)
raw_input("Press enter when the closed valve is in position...")
PWM.start(servo1,10,50)
