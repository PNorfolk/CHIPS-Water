###############################
#       Sets up servo 3       #
#   before running maincode   # 
###############################

import Adafruit_BBIO.PWM as PWM
from time import sleep

# The pins we'll use
servo3="P9_16"

#Setting up servo 3:
print ("Setting up servo 3: Setting duty cycle at 8.6")
PWM.start(servo3,8.6,50)
raw_input("Press enter when the open valve is in position...")
PWM.start(servo3,10,50)
sleep(1)
PWM.start(servo3,2,50)
