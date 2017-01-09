fs = h.SampleRate;

s = s(:, 1:22);

c1 = trigg(s, h.TRIG(ismember(h.Classlabel, 1)), round(0*fs), round(7.5*fs));
c234 = trigg(s, h.TRIG(not(ismember(h.Classlabel, 1))), round(0*fs), round(7.5*fs));

c1 = c1';
c234 = c234';

[v,d] = csp(c1, c234)
