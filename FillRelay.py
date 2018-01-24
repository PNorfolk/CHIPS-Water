import Adafruit_BBIO.GPIO as GPIO

fill="P8_9"
drain="P8_15"

GPIO.setup(fill, GPIO.OUT)
GPIO.setup(drain, GPIO.OUT)

GPIO.output(fill, GPIO.HIGH)
GPIO.output(drain, GPIO.LOW)
