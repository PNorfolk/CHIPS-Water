#Use this to set the servo at different angles

import Adafruit_BBIO.PWM as PWM
servoPin="P9_14"
PWM.start(servoPin,2,50)
while(1):
        desiredAngle=input("What Angle do You Want")
        dutyCycle=(8.8/180)*desiredAngle + 3  # NEED TO FIND OUR VARIABLES
        PWM.set_duty_cycle(servoPin,dutyCycle)
