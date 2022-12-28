# Управление вентилятором

## Raspberry pi

Управление вентилятором на кросс-плате для одноплатников Raspberry Pi 3/4 реализовано через GPIO17 (11 пин на 40-контактной гребёнке)
Самый простой способ, реализующий релейное пороговое управления - через оверлей gpio-fan.

```console 
dtoverlay -h gpio-fan
Name:   gpio-fan

Info:   Configure a GPIO pin to control a cooling fan.

Usage:  dtoverlay=gpio-fan,<param>=<val>

Params: gpiopin                 GPIO used to control the fan (default 12)
        temp                    Temperature at which the fan switches on, in
                                millicelcius (default 80000)
```

Так, для автоматического включения вентилятора при температуре 55 градусов, нужно в ```/boot/config.txt``` добавить строку

```
dtoverlay=gpio-fan,gpiopin=17,temp=55000
```

и перезагрузить одноплатный компьютер


## OrangePi 3Lts

Создать директорию ```~/fan```

```$ mkdir -p ~/fan```

В созданную директорию записать файл [fan.sh](fan/fan.sh) со следующим содержимым

```
#!/bin/bash

FAN_PIN=10
TEMP_L=49000
TEMP_H=55000

GPIO=/usr/local/bin/gpio
$GPIO mode $FAN_PIN out

#TEMP=`cat /sys/class/thermal/thermal_zone0/temp`

if [ "$TEMP" -gt "$TEMP_H" ]; then 
$GPIO write $FAN_PIN 1
fi

if [ "$TEMP" -lt "$TEMP_L" ]; then 
$GPIO write $FAN_PIN 0
fi
```

В данном примере вентилятор будет включаться при температуре 55°C, а выключаться - при 49°C

Добавить расписание из 3 правил в crontab:

```
$ crontab -e
```

```
* * * * *   /home/pi/fan/fan.sh
* * * * *   sleep 20; /home/pi/fan/fan.sh
* * * * *   sleep 40; /home/pi/fan/fan.sh```
```
Поскольку минимальный интервал cron-заданий составляет 1 минуту, воспользуемся таким трюком - запуском скрипта с задержкой

После добавления расписания каждые 20 секунд будет проверяться температура ядра процессора, и включаться/выключаться вентилятор в соответствии с заданными порогами.
