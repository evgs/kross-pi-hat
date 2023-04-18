# kross-pi-hat

Кросс-плата для подключения 3.5" штатных экранов 3D-принтеров Flying Bear Ghost6 и Reborn2 к одноплатным компьютерам OrangePi 3LTS и Raspberry Pi 3/4

![connected](images/hats.jpg)

Подключение производится родными шлейфами IDC10 без необходимости использовать одиночные соединители Dupont. Также кросс-плата предостваляет возможность установки управляемого вентилятора формата 3007 или 3010 5В.

На плате присутствует разъём XH2.54, позволяющий подать питание +5В на одноплатный компьютер без необходимости использовать кабель USB Type-C.

Дополнительно на плате выведены два 4-контактных разъёма I2C, а также оставшиеся неиспользованными линии GPIO.

В настоящее время существует 2 типа платы - для OrangePi 3LTS (синяя маска) и для Raspberry Pi3 (зелёная маска). Различаются схемой соединения GPIO и расположением монтажных стоек.

### Размещение разъёмов на плате.
![Connectors](images/kross-xpi-v1.png)

### Назначение разъёмов

| Обозначение | Назначение                                      | Ответный тип |
|----|----------------------------------------------------------|-------|
| X1 | Соединение с GPIO-разъёмом на одноплатном компьютере     | PLD26 |
| X2 | PWR+5V, подача питания на одноплатный компьютер          | XH2.54F-2 |
| X3 | Подключение управлякмого вентилятора 3007/3010 5В        | XH2.54F-2 |
| X4, X5 | Подключение устройств I2C. Интерфейс 3.3В            | BLS-04 |
| X6 | соединение UART с платой управления принтером (MCU-UART) | BLS-03 |
| X7 | Свободные пины GPIO                                      | BLD-06 |
| EXP1, EXP2 | подключение 3.5" TFT дисплея                     | IDC10F, шлейф |

### Таблица соединений

![Pinout](images/pinout_v1.png)



Подключение ЖКИ соответствует известным руководствам https://github.com/Sergey1560/fb4s_howto/blob/master/mks_ts35/ и https://github.com/evgs/FBG6-Klipper/blob/main/Klipperscreen-RPI.md.

***ВНИМАНИЕ*** При подключении соблюдать нумерацию разъёмов и выводов! EXP1->EXP1, EXP2->EXP2. 
Если возникли сомнения, соединить только разъёем EXP1, и прозвонить соответствие связности линий GND и +5V между кросс-платой и модулем дисплея.

***Внимание*** MKS традиционно использует перевёрнутые разъёмы IDC10, из-за чего обозначение первого вывода разъёма на плате и на шлейфе не совпадает.
Ошибка известная, давно перешедшая в ранг "особенность", поэтому воспроизведена на разработанных кросс-платах.
Разъёмы запаяны развёрнуто, и можно использовать комплектные шлейфы без каких-либо переделок.

![connected](images/hat-connected.jpg)

### Управляемая периферия

Кроме непосредственно дисплея, кросс-плата позволяет управлять подсветкой дисплея, активным зуммером на плате дисплея, вентилятором и реле питания 3d-принтера.
Также предоставляются разъёмы для подключения UART и I2C

#### X3 FAN
| пин  |GPIO Raspberry PI|GPIO Orange Pi|
|------|-----------------|--------------|
| \[1\]| +5V             | +5V          |
|  2   |GPIO17 (WPI0)    |PD16 (WOP10)  |

Силовая часть вентилятора реализована на полевом транзисторе, максимальный пиковый ток 2А. Рекомендуется применение вентиляторов 3007/3010 5В, до 300мА
(TODO: перечень типов применяемых транзисторов для разных ревизий платы)


#### X4, X5 I2C
| Пин | GPIO Raspberry Pi | GPIO Orange Pi |
|-----|-------------------|----------------|
|  \[1\]  | PWR_3V3           | PWR_3V3        |
|  2  | GPIO2 I2C1_SDA    | PD26 I2C0_SDA  |
|  3  | GPIO3 I2C1_SDA    | PD25 I2C0_SCL  |
|  4  | GND               | GND            |

#### X6 UART
| Пин | GPIO Raspberry Pi     | GPIO Orange Pi    |
|-----|-----------------------|-------------------|
|  \[1\]  | GPIO15 TXD0 (ttyAMA0) | PD23 TXD3 (ttyS3) |
|  2  | GPIO14 RXD0 (ttyAMA0) | PD25 RXD3 (ttyS3) |
|  3  | GND                   | GND               |

#### X7 (Raspberry Pi)
| GPIO | Пин   | Пин | GPIO (RPI)   |
|------|-------|-----|--------------|
| GND  | \[1\] |  2  | не задействован |
| GND  |  3    |  4  | GPIO4   |
| GND  |  5    |  6  | GPIO22  |

В настоящее время контакты разъёма не задействованы.


#### X7 (Orange Pi3 LTS)
| GPIO | Пин   | Пин | GPIO (OPI3LTS) |
|------|-------|-----|--------------|
| GND  | \[1\] |  2  | PD22         |
| GND  |  3    |  4  | PL02 PWREN   |
| GND  |  5    |  6  | PL03 PWR_BTN |

PL02 PWREN рекомендуемый сигнал удержания питания при использовании BTT RELAY

PL03 PWR_BTN - зарезервировано для считывания нажатия кнопки включения BTT RELAY (TODO)

#### EXP1 (Звуковой сигнал и подсветка)

| Пин |Функция  |GPIO Raspberry PI|GPIO Orange Pi|
|-----|---------|-----------------|--------------|
|  1  |BUZZER   |GPIO27 (WPI2)    |PD21 (WOP13)  |
|  3  |Backlight|GPIO18 (WPI1)    |PD18 (WOP6)   |

На кросс-платах для OrangePi3 в цепи Backlight установлен подтягивающий резистор 10K для совместимости с оригинальным драйвером от Сергея Терентьева, в котором отсутствует управление подсветкой дисплея.

По управлению питанием см. https://github.com/evgs/OrangePi3Lts/tree/main/power

Управление вентилятором https://github.com/evgs/kross-pi-hat/blob/main/fan.md

Управление звуковым излучателем https://github.com/evgs/kross-pi-hat/blob/main/buzzer.md

Подключение датчиков по I2C, на примере BME280 https://github.com/Tombraider2006/klipperFB6/tree/main/bme280
