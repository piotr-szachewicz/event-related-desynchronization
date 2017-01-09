[s,h] = load_data('A01T_red_bp.gdf');

%for i = 1:4
%    subplot(2,2,i)
%    plot_fft(s,h,1);
%end

[f, y1] = calc_fft(s,h,1);
[f, y2] = calc_fft(s,h,2);
[f, y3] = calc_fft(s,h,3);
[f, y4] = calc_fft(s,h,4);

figure
plot(f, y1, f, y2, f, y3, f, y4); 
xlim([0 125]) 
xlabel('Frequency (Hz)') 
ylabel('Amplitude') 
legend('left hand', 'right hand', 'foot', 'tongue');
save_plot('eeg_fft_red');

