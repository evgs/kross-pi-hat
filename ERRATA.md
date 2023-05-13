# Список известных ошибок на кросс-платах "Panama RPI" и "Panama OPI3LTS"

## KROSS-OPI
Первая версия, ограниченный бетатест
1. Расстояние между крепежными отверстиями 49мм вместо 50мм (ошибочно взято с RPI);
2. Смещение GPIO-разъёма относительно правильного размещения (почти 2мм)

Решение - отверстия расширены до совпадения с ответными отверстиями в стойках.
Платы дополнительно укомплектованы шайбами

## PANAMA-OPI V2
Первая коммерческая партия
1. Расстояние между крепежными отверстиями 49мм вместо 50мм (ошибочно взято с RPI);
2. Ошибка в маркировке пинов разъёма X7

Решение 1. Платы укомплектованы крепежом M2.5, с использованием которого ответные отверстия в стойках находятся в допуске.

Решение 2. При выполнении коммутации пользоваться исправленной таблицей

#### X7 (Orange Pi3 LTS)
| GPIO | Пин   | Пин | GPIO (OPI3LTS) |
|------|-------|-----|--------------|
| GND  | \[1\] |  2  | PD22         |
| GND  |  3    |  4  | PL02 PWREN   |
| GND  |  5    |  6  | PL03 PWR_BTN |
