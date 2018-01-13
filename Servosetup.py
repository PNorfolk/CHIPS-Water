################################
#  Setups servos 1 & 2 before  #
#      running maincode        # 
################################

import Adafruit_BBIO.PWM as PWM

# The pins we'll use
servo1="P9_14"
servo2="P9_16"

#Setting up servo 1:
print ("Setting up servo 1: " \n "Setting duty cycle at 8.6.")
PWM.start(servo1,8.6,50)
input("Press enter when the closed valve is in position...")
PWM.start(servo1,10,50)

#Setting up servo 2:
print ("Setting up servo 2: " \n "Setting duty cycle at 4")
PWM.start(servo2,4,50)
input("Press enter when the open valve is in position...")
PWM.start(servo2,2,50)
