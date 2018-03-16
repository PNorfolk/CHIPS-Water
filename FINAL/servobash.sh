#!/bin/bash

#        Servo Control           #


# This is a script to control all 3 servo 
# valves open/close according to the valve logistics document

# Defining the Pins

servo1='P9_14'
servo2='P8_19'
servo3='P9_22'

# PWM settings

period=20000000

open=500000
closed=2000000

# Setting the pins to pwm mode

sudo config-pin $servo1 pwm
sudo config-pin $servo2 pwm
sudo config-pin $servo3 pwm

# Overlaying Device Trees

echo BB-PWM0 > /sys/devices/platform/bone_capemgr/slots
echo BB-PWM1 > /sys/devices/platform/bone_capemgr/slots
echo BB-PWM2 > /sys/devices/platform/bone_capemgr/slots

# Creating PWM locations on Chips

pwmchip2="/sys/class/pwm/pwmchip2"
pwmchip0="/sys/class/pwm/pwmchip0"
pwmchip4="/sys/class/pwm/pwmchip4"

echo 0 > $pwmchip2/export
echo 0 > $pwmchip4/export
echo 0 > $pwmchip0/export

# Some useful shortcuts

pwm1=$pwmchip2/pwm0
pwm2=$pwmchip4/pwm0
pwm3=$pwmchip0/pwm0

# Setting up initial servo conditions 

echo $period > $pwm1/period
echo $period > $pwm2/period
echo $period > $pwm3/period

#This sets up the servos into their initial positions for cycle No. 0
echo 1720000  > $pwm1/duty_cycle 
echo 1 > $pwm1/enable
read -p "Press enter when valve 1 is closed and in position... "
echo $closed > $pwm1/duty_cycle 
sleep 2.0
echo 0 > $pwm1/enable
echo 1720000  > $pwm2/duty_cycle 
echo 1 > $pwm2/enable
read -p "Press enter when valve 2 is closed and in position... "
echo $closed > $pwm2/duty_cycle 
sleep 2.0
echo $open > $pwm2/duty_cycle 
sleep 2.0
echo 0 > $pwm2/enable
echo 1720000  > $pwm3/duty_cycle 
echo 1 > $pwm3/enable
read -p "Press enter when valve 3 is closed and in position... "
echo $closed > $pwm3/duty_cycle
sleep 2.0
echo $open > $pwm3/duty_cycle 
sleep 2.0
echo 0 > $pwm3/enable

# Big continuous loop of the 4 cycles
# When asked what cycle you want to run, enter numbers 0-3, 
#indicating Filtration, Filling, Measurement or Draining cycle respectively.
# If anything else is input, the loop will be exited with pumps
# turned off and PWM pins turned off and cleaned up

delay=2.0  #Setting the delay between servos turning, to prevent 
#too much current being drawn at once.

echo "What cycle do you want to run?  "
read cycleNo

while true
do
        if [ "$cycleNo" == "0" ]
        then
                echo "Filtration cycle activated "  
                #servo2=open, servo1=closed, servo3=closed.  
                # Fill pump is turned on.
                python Relay/OffRelay.py
                echo $open > $pwm2/duty_cycle ; echo 1 > $pwm2/enable 
                sleep $delay
                echo 0 > $pwm2/enable ; sleep $delay
                echo $closed > $pwm1/duty_cycle ; echo 1 > $pwm1/enable
                sleep $delay
                echo 0 > $pwm1/enable ; sleep $delay 
                echo $open > $pwm3/duty_cycle ; echo 1 > $pwm3/enable 
                sleep $delay
                echo 0 > $pwm3/enable ; sleep $delay
                python Relay/FillRelay.py
                echo "What cycle do you want to run?  "
                read cycleNo

        elif [ "$cycleNo" == "1" ]
        then
                echo "Filling cycle activated "
                #servo1=open, servo2=closed, servo3=closed. Fill pump turned on
                echo "How long do you want to fill for? (s) "
                read filltime
                
                echo $open > $pwm1/duty_cycle ; echo 1 > $pwm1/enable 
                sleep $delay
                echo 0 > $pwm1/enable ; sleep $delay
                echo $closed > $pwm2/duty_cycle ; echo 1 > $pwm2/enable
                sleep $delay
                echo 0 > $pwm2/enable ; sleep $delay
                echo $closed > $pwm3/duty_cycle ; echo 1 > $pwm3/enable 
                sleep $delay
                echo 0 > $pwm3/enable ; sleep $delay
               
               python Relay/FillRelay.py
                sleep $filltime
                cycleNo=2
                
        elif [ "$cycleNo" == "2" ]
        then
                echo "Measurement cycle activated "
                # all valves closed, pumps turned off.
                python Relay/OffRelay.py

                echo $closed > $pwm1/duty_cycle ; echo 1 > $pwm1/enable 
                sleep $delay
                echo 0 > $pwm1/enable ; sleep $delay 
                echo $closed > $pwm2/duty_cycle ; echo 1 > $pwm2/enable
                sleep $delay
                echo 0 > $pwm2/enable ; sleep $delay
                echo $closed > $pwm3/duty_cycle ; echo 1 > $pwm3/enable 
                sleep $delay
                echo 0 > $pwm3/enable ; sleep $delay
                echo "What cycle do you want to run?  "
                read cycleNo
        
        elif [ "$cycleNo" == "3" ]
        then    
                echo "Draining cycle activated "
                #Servo3=open,servo1=closed, servo1=closed.
                # Drain pump is turned on.
                echo "How long do you want to drain for? (s) "
                read draintime
                
                echo $open > $pwm3/duty_cycle ; echo 1 > $pwm3/enable 
                echo $open > $pwm3/duty_cycle ; echo 1 > $pwm3/enable 
                sleep $delay
                echo 0 > $pwm3/enable ; sleep $delay
                echo $closed > $pwm1/duty_cycle ; echo 1 > $pwm1/enable
                sleep $delay
                echo 1 > $pwm1/enable ; sleep $delay
                echo $closed > $pwm2/duty_cycle ; echo 1 > $pwm2/enable 
                sleep $delay
                echo 0 > $pwm2/enable ; sleep $delay

                echo "draining for $draintime seconds "
                sleep $draintime
                cycleNo=2

       
       else       #Turns off pumps, and cleans up the GPIO pins. 
                python Relay/RelayCleanup.py
                echo "***STOPPING PUMPSYSTEM***"
                sleep $delay    
                echo 1 > $pwm1/enable ; echo 1720000 > $pwm1/duty_cycle
                sleep $delay ; echo 0 > $pwm1/enable             	
                sleep $delay    
                echo 1 > $pwm2/enable ; echo 1720000 > $pwm2/duty_cycle 
                sleep $delay ; echo 0 > $pwm2/enable 
                sleep $delay    
                echo 1 > $pwm3/enable ; echo 1720000 > $pwm3/duty_cycle
                sleep $delay ; echo 0 > $pwm3/enable 
                sleep $delay    

                break

fi 
done
