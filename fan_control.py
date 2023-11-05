import psutil
import gpiozero
import time
import os
import numpy as np
import scipy.interpolate as interpolate

if __name__ == "__main__":
    fan_curve = os.path.join(os.path.dirname(__file__), "fan_curve.dat")
    fan = gpiozero.PWMOutputDevice(14)

    T, V = np.loadtxt(fan_curve).T
    curve = interpolate.interp1d(T, V, fill_value=(0, V[-1]), bounds_error=False)

    while True:
        temp = psutil.sensors_temperatures().get('cpu_thermal')[0].current
        fan.value = curve(temp)
        time.sleep(10)
