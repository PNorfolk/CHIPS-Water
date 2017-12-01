#USE THIS TO READ OUT THE VOLTAGE AND ADC FROM THE PIN DIODE
#THIS WILL SAVE THE READINGS TO FILES: PDvolt.txt and PDadc.txt
#NOTE: USE PIN 33 AS VIN

import Adafruit_BBIO.ADC as ADC
ADC.setup()
from time import sleep
file1 = open('PDVolt.txt','w')
file2 = open('PDadc.txt','w')
Apin="P9_33"
p=0
slp=0.5
while p<10000:
	val=ADC.read(Apin)
	volt=val*1.8
	adc=ADC.read_raw(Apin)
	print "The Voltage is:", volt, ". The ADC is:", adc 
	Time=p*slp
	file2.write(str(Time) + " " +  str(adc) + "\n")
	file1.write(str(Time) + " " +  str(volt) + "\n")
	sleep(slp)
	p=p+1
file1.close
file2.close
