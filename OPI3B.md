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

Скачать программу управления вентилятором

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

## Управление питанием

см. https://github.com/evgs/OrangePi-rk3566

TODO: Сделать вариант подключения реле через "панамку"

