#!/bin/bash

comando=$1
intervalo=2

#Manejo Argumentos

if [ $# -eq 2 ]; then
    intervalo=$2

elif [ $# -eq 0 ] || [ $# -gt 2 ]; then
    echo "USO: $0 <comando> <intervalo de tiempo>"
    exit 1
fi

#Lanzar comando

$comando &



PID=$!
echo "$PID"

#Manejo Finalizacion 

trap "kill $PID" SIGINT

#Registro de datos

while (kill -0 $PID 2>/dev/null)
do
    ps -p $PID -o %cpu,%mem,rss --no-headers
    sleep $intervalo
done



