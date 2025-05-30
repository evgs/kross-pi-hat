# "Панамка и OrangePi 3B

!!! Внимание, мануал экспериментальный, правится по мере отлова багов

В данной статье описывается настройка программной поддержки переходной платы "Панамки" на одноплатный компьютер OrangePi 3B 
с целью подключения штатного дисплея MKS TS35-R V2.0 (штатный дисплей, используемый в 3D-принтерах Flying Bear Ghost6 и Flying Bear Reborn 2)

## Общие требования

* Одноплатный компьютер Orange Pi 3B (далее по тексту OPi3B)
* Переходная плата PANAMA-RPI (OPi3B механически и по распиновке GPIO40 совместим с модулями для RPI3 и RPI4)
* Вентилятор 3007 5В (опционально, подключается и управляется через PANAMA-RPI
* Debian Bookworm (standard server) с kernel 5.10.170 (установлен на карту памяти или EMMC)
* Установленный KlipperScreen (рекомендуется)

## Настройка вентилятора

Скачать сервис управления вентилятором

```shell
cd ~
git clone https://github.com/evgs/fan-pwm-opi
cd fan-pwm-opi
git switch opi3b
./install.sh
```

По умолчанию вентилятор включается начиная с температуры процессора 50°C, подробности [здесь](https://github.com/evgs/fan-pwm-opi?tab=readme-ov-file#%D0%BD%D0%B0%D1%81%D1%82%D1%80%D0%BE%D0%B9%D0%BA%D0%B0)

## Настройка поддержки дисплея

Установить драйвер дисплея
``` shell
cd ~ 
rm -r fb_st7796s
git clone https://github.com/evgs/fb_st7796s.git
cd ~/fb_st7796s
git switch opi3b-rk3566
~/fb_st7796s/install_opi3b.sh
```
Если дисплей повёрнут горизонтально, то дополнительно запустить скрипт

```shell 
~/fb_st7796s/switch_to_landscape_opi3lts.sh
```
Перезагрузить одноплатный компьютер для запуска драйвера

```shell
sudo reboot
```

## Улучшенная тема Klipperscreen 

Рекомендую установить модифицированную [тему экрана](https://github.com/evgs/KlipperScreen-zbolt3.5) с более читаемыми шрифтами

```shell
cd ~
git clone https://github.com/evgs/KlipperScreen-zbolt3.5
~/KlipperScreen-zbolt3.5/install.sh
```

!!! Внимание! В скрипте установки экспериментальный автовыбор свежеустановленной темы. Если после установки темы клипперскрин начал циклически перезапускаться 
и ругаться на файл конфигурации, то либо почистите полностью "хвостовые настройки ```#~#``` в ~/printer_data/config/KlipperScreen.conf , либо полностью удалите этот файл (он автоматически пересоздастся) и выьерите тему вручную

## Управление питанием

см. https://github.com/evgs/OrangePi-rk3566

TODO: Сделать вариант подключения реле через "панамку"

## Таблица соединений

### Дисплей
| EXP1 | цепь        | RK3566 GPIO   | GPIO40 |
|:----:|-------------|---------------|:------:|
| [1]  | BEEP        | nc            | nc     |
| 2    | BTN_ENC     | nc            | nc     |
| 3    | LCD_BLK     | GPIO3_С7      | 12     |
| 4    | LCD_RST     | GPIO4_B1      | 22     |
| 5    | TOUCH_CS    | GPIO4_A7      | 26     |
| 6    | PENDOWN_IRQ | GPIO4_A3      | 16     |
| 7    | LCD_CS      | GPIO4_A6      | 24     |
| 8    | LCD_RS      | GPIO4_A1      | 18     |
| 9    | GND         | GND           | 14     |
| 10   | BOARD_5V    | 5V (BOARD)    | 2, 4   |

| EXP2 | цепь        | RK3566 GPIO   | GPIO40 |
|:----:|-------------|---------------|:------:|
| [1]  | MISO        | GPIO4_B0      | 21     |
| 2    | SCK         | GPIO4_B3      | 23     |
| 3    | BTN_EN1     | nc            | nc     |
| 4    | nc          | nc            | nc     |
| 5    | BTN_EN2     | nc            | nc     |
| 6    | MOSI        | GPIO4_B2      | 19     |
| 7    | nc          | nc            | nc     |
| 8    | RESET       | nc            | nc     |
| 9    | GND         | GND           | 25     |
| 10   | BOARD_3.3V  | nc            | nc     |

### I2C
| X4, X5 | цепь        | RK3566 GPIO   | GPIO40 |
|:------:|-------------|---------------|:------:|
| [1]    | +3.3V       | I2C VDD       | 1      |
| 2      | SDA         | GPIO4_B4      | 3      |
| 3      | SCL         | GPIO4_B5      | 5      |
| 4      | GND         | GND           | 9      |

### Питание 5В
| X2     | цепь        | RK3566 GPIO   | GPIO40 |
|:------:|-------------|---------------|:------:|
| [1]    | +5V         | 5V (BOARD)    | 2, 4   |
| 2      | GND         | GND           | 9      |

### Вентилятор SBC (3007 5V)
| X3     | цепь        | RK3566 GPIO     | GPIO40 |
|:------:|-------------|-----------------|:------:|
| [1]    | +5V         | 5V (BOARD)      | 2, 4   |
| 2      | FAN GND     | GPIO3_C6 (GATE) | 11     |

### UART
| X6     | цепь        | RK3566 GPIO   | GPIO40 |
|:------:|-------------|---------------|:------:|
| [1]    | UART2_TXD   | GPIO0_D1      | 8      |
| 2      | UART2_RXD   | GPIO0_D0      | 10     |
| 3      | GND         | GND           | 14     |

### AUX
| X7     | цепь        | RK3566 GPIO   | GPIO40 |
|:------:|-------------|---------------|:------:|
| [1]    | GND         | GND           | 25     |
| 2      | /AUX2       | /GPIO4_A2*    | 10     |
| 3      | GND         | GND           | 25     |
| 4      | AUX1        | GPIO4         | 7      |
| 5      | GND         | GPIO0_D0      | 25     |
| 6      | AUX2        | GPIO4_A2      | 15     |

* (TODO) Пин подключён к базе VT2 (BCR108), может быть использован для опроса состояния BTT Relay 
Коллектор VT2 соединён с GPIO4_A2
