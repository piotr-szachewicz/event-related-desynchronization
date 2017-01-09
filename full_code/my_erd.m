%s(isnan(s)) = 0;

function [s_avg_erd,s_avg_ers,t] = get_erd(s,h,channel)

fs = h.SampleRate;
class = 2;
%channel = 14; % C3

erd_bandpass = [8,12];
ers_bandpass = [14, 18];
%b_erd = fir1(fs, erd_bandpass/(fs/2));
[b_erd, a_erd] = butter(5, erd_bandpass/(fs/2));
[b_ers, a_ers] = butter(5, ers_bandpass/(fs/2));

st = trigg(s, h.TRIG(ismember(h.Classlabel, class)), round(0*fs), round(7.5*fs));
s2d = reshape(st(channel,:),[1876, 72]);

% ERD
s_filt = filter(b_erd, a_erd, s2d);
s_sq = s_filt.^2;
s_avg_erd = sum(s_sq, 2) / size(s2d,2);

baseline = mean(s_avg_erd(1*fs:2*fs));
s_avg_erd = (s_avg_erd - baseline) / baseline * 100;


% ERS
s_filt_ers = filter(b_ers, a_ers, s2d);
s_sq_ers = s_filt_ers.^2;
s_avg_ers = sum(s_sq_ers, 2) / size(s2d,2);

baseline = mean(s_avg_ers(1*fs:2*fs));
s_avg_ers = (s_avg_ers - baseline) / baseline * 100;

t = (0:size(s_avg_erd)-1)/fs;

%LOWPASS FILTERING
[b, a] = butter(11, 10./(fs/2));
s_avg_erd = filter(b,a,s_avg_erd)';
s_avg_ers = filter(b,a,s_avg_ers)';
t = t';

end

[s,h] = load_data('A07T_red_bp.gdf');

subplot(2,1,1);
[erd,ers,t]=get_erd(s,h,8);
title('Electrode C3');
plot(t, erd, '3', t, ers, '1')
ylabel('C3 relative power [%]');
ylim([-150, 250]);
line([2, 2], [-150, 250], 'LineStyle', ':', 'Color', 'k');
legend('mu band', 'beta band');
grid('on');

subplot(2,1,2);
[erd,ers,t]=get_erd(s,h,12);
title('Electrode C4');
plot(t, erd, '3', t, ers, '1')
ylabel('C4 relative power [%]');
ylim([-150, 250]);
line([2, 2], [-150, 250], 'LineStyle', ':', 'Color', 'k');
xlabel('Time [s]');
legend('mu band', 'beta band');
grid('on');

