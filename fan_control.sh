#!/bin/sh

pid=$(cat ~/fan_control/process_pid)

if kill -0 "$pid" 2>/dev/null; then
    kill $pid
    echo "" > ~/fan_control/process_pid
    echo "Stopped the fan control on PID $pid!"
else
    GPIOZERO_PIN_FACTORY=rpigpio python3 ~/fan_control/fan_control.py &
    pid=$!
    echo $pid > ~/fan_control/process_pid
    echo "Started the fan control on PID $pid!"
fi
