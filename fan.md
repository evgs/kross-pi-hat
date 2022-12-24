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

//TODO
