### Takes a measurement on the diode ###

# Device tree overlay for ADC
echo BB-ADC  > /sys/devices/platform/bone_capemgr/slots


SYSFS_ADC_DIR="/sys/bus/iio/devices/iio:device0/in_voltage4_raw"

# reading a filename to output the data to
echo "Enter file name including extension: "
read file_name
> $file_name

#initialising variables
i="0"
toAverage=10

while [ $i -lt 30 ]
    do
        file_name_adc="$file_name.txt"
#gets the value of ADC from the directory
        total=0
        #finds the voltage from the photodiode and reads toAverage times
        for ((j=0;j<$toAverage;j++))
        do
          adc=`cat "$SYSFS_ADC_DIR"`
          if [ -z $adc ]; then adc=`cat "$SYSFS_ADC_DIR"`;fi
          if [ -z $adc ]; then adc=`cat "$SYSFS_ADC_DIR"`;fi
          if [ -z $adc ]; then echo "Warning ! ADC did not read!";fi

          total=$(( $total + $adc ))
        done

        #finds the average from the total voltage read over toAverage times
        #averages=$total/$toAverage

        echo $total $toAverage >> $file_name
        sleep 1.0
        i=$[$i+1]        
        done
# This divides the first column by the second column
# producing a list of averaged values
awk '{$1 = $1 / $2}1' $file_name > new.txt
awk '{print $1}' new.txt > $file_name
rm new.txt

    done
