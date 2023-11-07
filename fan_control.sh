#!/bin/sh

BASEDIR=$(dirname "$0")
pid=$(cat ${BASEDIR}/process_pid)

if kill -0 "$pid" 2>/dev/null; then
    kill $pid
    echo "" > ${BASEDIR}/process_pid
    echo "Stopped the fan control on PID $pid!"
else
    GPIOZERO_PIN_FACTORY=rpigpio python3 ${BASEDIR}/fan_control.py &
    pid=$!
    echo $pid > ${BASEDIR}/process_pid
    echo "Started the fan control on PID $pid!"
fi
