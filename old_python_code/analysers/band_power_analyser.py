from analysis.obci_signal_processing import smart_tags_manager as mgr
from analysis.obci_signal_processing.tags import smart_tag_definition as df
import numpy
from scipy.signal import *
from utils.iir_utils import *
from band_power_analyser import *

class BandPowerAnalyser:

    def __init__(self, file_name, start_time, end_time, low_freq, high_freq, sampling_frequency):
        self.file_name = file_name
        self.start_time = start_time
        self.end_time = end_time
        self.sampling_frequency = sampling_frequency

        low_freq_norm = low_freq / (sampling_frequency / 2)
        high_freq_norm = high_freq / (sampling_frequency / 2)
        self.b_coefficients, self.a_coefficients = iirfilter(4, Wn=[low_freq_norm, high_freq_norm], rp=3.0, rs=30, btype='bandpass', ftype='ellip')

    def draw_filter_response(self):
        mfreqz(self.b_coefficients, self.a_coefficients, self.sampling_frequency)

    def analyse(self, channel, tag_names):
        power = self._analyse(channel, tag_names, self.start_time, self.end_time)
        return power

    def get_baseline(self, channel, tag_names, baseline_start_time, baseline_end_time):
        power = self._analyse(channel, tag_names, baseline_start_time, baseline_end_time)
        print 'channel ' + str(channel) + ' baseline power = ' + str(len(power))
        return float(sum(power)) / len(power)

    def _analyse(self, channel, tag_names, start_time, end_time):

        definitions = []
        print 'definitons = ' + str(definitions)
        for tag_name in tag_names:
            d = df.SmartTagDurationDefinition(start_tag_name=tag_name, start_offset=start_time, end_offset=0, duration=end_time)
            print 'Added def: ' + str(tag_name) + ' ' + str(d)
            definitions = definitions + [d]
        print 'These are our definitions: ' + str(definitions)

        m = mgr.SmartTagsManager(definitions[0], self.file_name+'.xml', self.file_name+'.bin', self.file_name+'.tag')

        power = numpy.zeros(len(m.get_smart_tags()[0].get_samples()[0]))
        t = [x/float(self.sampling_frequency) for x in range(0,len(power))]

        for smart_tag in m.get_smart_tags():
            samples = smart_tag.get_samples()[channel]
            samples = filtfilt(self.b_coefficients, self.a_coefficients, samples)

            samples = numpy.multiply(samples, samples)
            power = numpy.add(power, samples)

        count = len(m.get_smart_tags())
        power = numpy.divide(power, count)
   
        #low-pass filter data

        return power

    def low_pass_filter(self, power):
        b2,a2 = iirfilter(4, Wn=[0.5/(self.sampling_frequency/2)], rp=3.0, rs=30, btype='lowpass', ftype='ellip')
        power = filtfilt(b2, a2, power)
        return power
    
