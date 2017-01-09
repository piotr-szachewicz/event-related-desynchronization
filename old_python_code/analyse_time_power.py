    #!/usr/bin/env python
    # -*- coding: utf-8 -*-

from pylab import *
import numpy
from scipy.signal import *
from analysers.band_power_analyser import *
from utils.plot_utils import *
import sys

file_name = '26_07/erd3_zuz'
file_name = 'data/' + file_name
low_freq = 8.0
high_freq = 12.0
tag_names = ['LEFT', 'RIGHT']
channel_names = ['C3', 'C4']

start_time = -7.0
end_time = 4.0

baseline_start_time = -4
baseline_end_time = 0 

sampling_frequency = 128.0

if (len(sys.argv) > 1):
    file_name = sys.argv[1]
    print 'ARG found -- file name: ' + str(file_name)
    if (len(sys.argv) == 4):
        low_freq = float(sys.argv[2])
        high_freq = float(sys.argv[3])
        print 'ARG found -- freq [low, high]: [' + str(low_freq) + ', ' + str(high_freq) + ']'

t=numpy.divide(range(int(start_time*sampling_frequency), int(end_time*sampling_frequency)), sampling_frequency)

analyser = BandPowerAnalyser(file_name, start_time, end_time, low_freq, high_freq, sampling_frequency)
analyser.draw_filter_response()

baseline = []
for channel_number in range(len(channel_names)):
    channel_baseline = analyser.get_baseline(channel_number, tag_names, baseline_start_time, baseline_end_time)
    print 'channel ' +  str(channel_names[channel_number]) + ' baseline = ' + str(channel_baseline)
    baseline = baseline + [channel_baseline]

sub = 221
for channel in [0, 1]:
    for hand in tag_names:
        power = analyser.analyse(channel, [hand])
        power = numpy.subtract(power, baseline[channel])
        power = analyser.low_pass_filter(power)
        subplot(sub)
        plot_power(t, power, channel_names[channel] + ' ' + hand + ' HAND')
        sub += 1

#baseline_analyser = BandPowerAnalyser(file_name, start_baseline_time, end_time, low_freq, high_freq, sampling_frequency)
baseline = analyser.analyse(0, ['LEFT', 'RIGHT'])
show()

