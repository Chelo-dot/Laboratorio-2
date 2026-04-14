#!/bin/bash

comando=("${@:1:$#-1}")
intervalo=2

#Manejo de Argumentos

if [ $# -eq 2 ]; then

    intervalo="${@: -1}"

elif [ $# -eq 0 ] || [ $# -gt 2 ]; then
    echo "USO: $0 <comando> <intervalo de tiempo>"
    exit 1
fi

#Lanzar comando

$comando &

PID=$!

#Manejo de Finalizacion 

cleanup(){

    kill -9 $PID

    #Graficación 
    TITULO="${comando} $PID"

    gnuplot <<EOF
    set terminal png
    set xrange [0:$time]
    set xtics 0, $intervalo, $time
    set output "monitor_$PID.png"
    set title "$TITULO"
    set xlabel "Tiempo(s)"
    set ylabel "%CPU"
    set y2label "RSS(KB)"
    set ytics nomirror
    set y2tics

    plot "monitor_$PID.log" using 3 with lines axes x1y1 title "CPU", "monitor_$PID.log" using 5 with lines axes x1y2 title "RSS"

EOF
    exit 0
}

trap cleanup SIGINT EXIT

#Registro de datos

time=0

while (kill -0 $PID 2>/dev/null)
do
    INFO=$(ps -p $PID -o %cpu,%mem,rss --no-headers)
    TIMESTAMP=$(date "+%Y-%m-%d %I:%M:%S")
    echo "$TIMESTAMP $INFO" >> monitor_$PID.log
    time=$((time + intervalo))

    sleep $intervalo

done





