from pylab import *

def plot_power(x_values, y_values, plot_title):
    ylabel('Power')
    xlabel('Time [sec.]')
    title(plot_title)
    grid(True)
    plot(x_values, y_values)


