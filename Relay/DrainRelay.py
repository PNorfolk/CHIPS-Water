import Adafruit_BBIO.GPIO as GPIO

fill="P8_9"
drain="P8_15"

GPIO.output(fill, GPIO.LOW)
GPIO.output(drain, GPIO.HIGH)
