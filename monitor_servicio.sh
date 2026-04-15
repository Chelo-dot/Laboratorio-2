#!/bin/bash


while (true)
do
    INFO=$(ps -e --sort=%cpu -o cmd,%cpu,%mem,rss --no-headers | tail -n 5)
    TIMESTAMP=$(date "+%Y-%m-%d %I:%M:%S")
    echo "$TIMESTAMP" >> monitor_servicio.log
    echo "$INFO" >> monitor_servicio.log

    sleep 5

done



