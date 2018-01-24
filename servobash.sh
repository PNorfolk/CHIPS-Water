#!/bin/bash

##################################
#        servo Control           #
#     -   Now in Bash   -        #
##################################

# This is a script to control all 3 servo 
# valves accoring to the valve logistics document

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

#Maybe I will include a section to setup the servos?
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

delay=2.0

echo "What cycle do you want to run?  "
read cycleNo

while true
do
        if [ "$cycleNo" == "0" ]
        then
                echo "Filtration cycle activated "
                echo $open > $pwm2/duty_cycle ; echo 1 > $pwm2/enable 
                sleep $delay
                echo 0 > $pwm2/enable ; sleep $delay
                echo $closed > $pwm1/duty_cycle ; echo 1 > $pwm1/enable
sleep $delay
                echo 0 > $pwm1/enable ; sleep $delay 
                echo $open > $pwm3/duty_cycle ; echo 1 > $pwm3/enable 
                sleep $delay
                echo 0 > $pwm3/enable ; sleep $delay
                echo "What cycle do you want to run?  "
                read cycleNo

        elif [ "$cycleNo" == "1" ]
        then
                echo "Filling cycle activated "
                echo $open > $pwm1/duty_cycle ; echo 1 > $pwm1/enable 
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
        elif [ "$cycleNo" == "2" ]
        then
                echo "Measurement cycle activated "
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
        
        else    
                echo "Draining cycle activated "
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
                echo "What cycle do you want to run?  "
                read cycleNo
        fi      
done    




