#!/bin/bash

FAN_PIN=10
TEMP_L=49000
TEMP_H=55000

GPIO=/usr/local/bin/gpio
$GPIO mode $FAN_PIN out

TEMP=`cat /sys/class/thermal/thermal_zone0/temp`

#echo $TEMP >> /tmp/fan.log

if [ "$TEMP" -gt "$TEMP_H" ]; then 
$GPIO write $FAN_PIN 1
fi

if [ "$TEMP" -lt "$TEMP_L" ]; then 
$GPIO write $FAN_PIN 0
fi

