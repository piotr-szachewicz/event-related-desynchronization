# -*- coding: utf-8 -*-
#!/usr/bin/env python

from pylab import *
import numpy
from scipy.signal import *
from plot_utils import *

def mfreqz(b, a, sampling_frequency):
    """Draws IIR filter frequency and phase response"""
    w,h = freqz(b,a)
    h_dB = 20 * log10 (abs(h))
    subplot(211)
    freq = w/max(w)*(sampling_frequency/2)

    grid(True)
    plot(freq,h_dB)
    ylim(-150, 5)
    ylabel('Magnitude (db)')
    xlabel('Frequency [Hz]')
    title('Frequency response')

    subplot(212)
    h_Phase = unwrap(arctan2(imag(h),real(h)))
    grid(True)
    h_Phase = unwrap(arctan2(imag(h),real(h)))
    plot(freq,h_Phase)
    ylabel('Phase (radians)')
    xlabel('Frequency [Hz]')
    title('Phase response')
    subplots_adjust(hspace=0.5)

    show()

