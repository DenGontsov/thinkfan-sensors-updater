#!/bin/bash

# Путь к конфигурационному файлу thinkfan
CONF_FILE="/etc/thinkfan.conf"

# Поиск всех доступных сенсоров температуры с использованием маски
HWMON_PATHS=$(find /sys/devices/platform/coretemp.0/hwmon/ -name "temp*_input")

# Проверка, найдены ли сенсоры
if [ -z "$HWMON_PATHS" ]; then
  echo "Температурные сенсоры не найдены!"
  exit 1
fi

# Очистка существующего конфигурационного файла thinkfan
echo "# Thinkfan configuration" > $CONF_FILE
echo "tp_fan /proc/acpi/ibm/fan" >> $CONF_FILE
# Генерация новой конфигурации на основе найденных сенсоров
for PATH in $HWMON_PATHS; do
  echo "hwmon $PATH" >> $CONF_FILE
done

# Добавление уровней скорости вентилятора
/usr/bin/cat <<EOL >> $CONF_FILE

(0, 0, 40)
(1, 40, 44)
(2, 44, 48)
(3, 48, 52)
(4, 52, 56)
(5, 56, 60)
(6, 60, 64)
(7, 64, 68)
(127, 68, 32767)
EOL

# Перезапуск thinkfan для применения новой конфигурации
/usr/bin/systemctl restart thinkfan
/usr/bin/systemctl status thinkfan

echo "Конфигурация thinkfan обновлена успешно!"
