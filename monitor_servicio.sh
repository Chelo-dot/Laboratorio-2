#!/bin/bash


while (true)
do
    INFO=$(ps -e --sort=-%cpu -o cmd,%cpu,%mem,rss --no-headers | head -n 5)
    TIMESTAMP=$(date "+%Y-%m-%d %I:%M:%S")
    echo "$TIMESTAMP" >> /var/log/monitor_servicio.log
    echo "$INFO" >> /var/log/monitor_servicio.log

    sleep 5

done



