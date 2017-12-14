import Adafruit_BBIO.GPIO as GPIO

IN1="P8_9"
IN2="P8_15"

GPIO.setup(IN1, GPIO.OUT)
GPIO.setup(IN2, GPIO.OUT)

in1 = int(input("Would you like IN1 high(1) or low(0)? "))
in2 = int(input("would you like IN2 high(1) or low(0)? "))

while(1):
        if in1 == 1:
                print ("IN1 is set high")
                GPIO.output(IN1, GPIO.HIGH)

                if in2 == 1:
                        print ("IN2 is set high")
                        GPIO.output(IN2, GPIO.HIGH)

                elif in2 == 0:
                        print ("IN2 is set low")
                        GPIO.output(IN2, GPIO.LOW)

                in1 = int(input("Would you like IN1 high(1) or low(0)? "))
                in2 = int(input("would you like IN2 high(1) or low(0)? ")) 
        elif in1 == 0:
                print ("IN1 is set low")
                GPIO.output(IN1, GPIO.LOW)

                if in2 == 1:
                        print ("IN2 is set high")
                        GPIO.output(IN2, GPIO.HIGH)

                elif in2 == 0:
                        print ("IN2 is set low")
                        GPIO.output(IN2, GPIO.LOW)

                in1 = int(input("Would you like IN1 high(1) or low(0)? "))
                in2 = int(input("would you like IN2 high(1) or low(0)? "))

