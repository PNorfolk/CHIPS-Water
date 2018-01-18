###############################
#        Sets up servos       #
#   before running maincode   # 
###############################

import Adafruit_BBIO.PWM as PWM
from time import sleep

# The pins we'll use
servo1="P9_14"
servo2="P9_22"
servo3="P9_42"

# Setting up servo 1: closed
print ("Setting up servo 1: Setting duty cycle at 8.6.")
PWM.start(servo1,8.6,50)
raw_input("Press enter when the closed valve is in position...")
print ("Closing valve")
PWM.start(servo1,10,50)
sleep(1)
PWM.stop(servo1)

# Setting up servo 2: open
print ("Setting up servo 2: setting duty cycle at 8.6")
PWM.start(servo2,8.6,50)
raw_input("Press enter when the closed valve is in position...")
print ("Closing valve")
PWM.start(servo2,10,50)
sleep(1)
print ("Opening valve")
PWM.start(servo2,2,50)
sleep(1)
PWM.stop(servo2)

# Setting up servo 3: open
print ("Setting up servo 3: setting duty cycle at 8.6")
PWM.start(servo3,8.6,50)
raw_input("Press enter when the closed valve is in position...")
print ("Closing Valve") 
PWM.start(servo3,10,50)
sleep(1)
print ("Opening valve")
PWM.start(servo3,2,50)
sleep(1)
PWM.stop(servo3)
