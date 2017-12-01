echo cape-bone-iio > /sys/devices/bone_capemgr.*/slots

#SYSFS_ADC_DIR="/sys/bus/iio/devices/iio:device0/in_voltage3_raw"
SYSFS_ADC_DIR="/sys/bus/iio/devices/iio:device0/in_voltage4_raw"

cat "$SYSFS_ADC_DIR"

file_name = PDadc.txt
> $file_name
i="0"
slp="0.5"

while [ $i -lt 4 ]
    do
        echo "about to write data to $file_name.txt "
        file_name_adc="$file_name.txt"
        adc=`cat "$SYSFS_ADC_DIR"`
        echo "adc is $adc " 
        t=`echo $slp \* $i |bc`; 
	echo "$t"
	echo $adc $t  >> $file_name
        sleep 0.5
	i=$[$i+1]        
	done
	

    done


