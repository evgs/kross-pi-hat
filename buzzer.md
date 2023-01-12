# Управление активным пъезоизлучателем (пищалкой) модуля MKS TS35-R V2.0

Пъезоизлучатель активируется транзисторным ключом TFT-модуля, подключён к контакту EXP1-1, и посредством кросс-платы соединяется с GPIO PD21 
в версии платы под Orange Pi3 LTS, и GPIO27 в версии под Raspberry Pi

# Настройка mcu host

Поскольку пин управления звукоизлучателем принадлежит Linux-процессору, необходимо настроить клиппер-контроллер mcu host (если ещё не настроен)
Оригинальное описание процесса настройки есть в документации клиппера https://www.klipper3d.org/RPi_microcontroller.html , ниже приводится краткая инструкция

## компиляция клиппер-контроллера mcu host

```console
$ cd ~/klipper/
$ make menuconfig
```

Строку ```Microcontroller Architecture``` установить в ```Linux process```, сохранить и выйти обратно в консоль. 

Далее компилируем и устанавливаем

```console
$ sudo service klipper stop
$ make
$ make flash
$ sudo service klipper start
```

Добавим скрипт запуска mcu host в автозагрузку и запускаем его

```console
$ sudo cp "~/klipper/scripts/klipper-mcu-start.sh" /etc/init.d/klipper_mcu
$ sudo update-rc.d klipper_mcu defaults
$ sudo service klipper_mcu start
```

Проверяем, что процесс mcu-host работает - в директории /tmp/ должна присутствовать символическая ссылка на псевдотерминал 
(функциональный аналог serial-соединения c физическим последовательным портом)

```console
$ ls -l /tmp/
lrwxrwxrwx 1 root root 10 дек 31 20:58 klipper_host_mcu -> /dev/pts/0
```

## Подключение klipper к mcu host

в файл printer.cfg добавляем секцию. Добавляем в любое удобное место, лучше всего - сразу после похожей секции \[mcu\]

```
[mcu host]
serial: /tmp/klipper_host_mcu
```

Сохраняем файл и производим FIRMWARE_RESTART

# Макрос подачи звукового сигнала BEEP

в printer.cfg добавляем секцию

```
[gcode_macro BEEP]
gcode:
    {% set duration = params.P|default(100)|float %}    
    SET_PIN PIN=buzzer VALUE=1
    G4 P{duration}
    SET_PIN PIN=buzzer VALUE=0
```    
Звуковой сигнал можно подавать, вставляя вызов макроса BEEP в G-код.
По умолчанию длительность 100мс, более длинный сигнал задаётся параметром P, например, ```BEEP P=1000```

# Настройка GPIO для Orange Pi3 LTS

в printer.cfg добавляем секцию

```
[output_pin buzzer]
pin: host:gpiochip1/gpio117
```

Сохраняем файл и производим FIRMWARE_RESTART

# Настройка GPIO для Raspberry Pi 3/4 

в printer.cfg добавляем секцию

```
[output_pin buzzer]
pin: host:gpiochip0/gpio27
```

Сохраняем файл и производим FIRMWARE_RESTART
