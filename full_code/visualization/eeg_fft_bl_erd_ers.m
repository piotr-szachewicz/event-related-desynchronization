
for subject = 1:9
    filename = sprintf('A0%dT_red_bp.gdf', subject);
    [s,h] = load_data(filename);
    
    channels = [8,12]
    classes = {'left_hand', 'right_hand', 'feet', 'tongue'};

    figure
    for class = [1,2,3,4]
        for c = [1,2]
            printf('Drawing subject %d, class %d, channel %d\n', subject, class, channels(c));
            channel = channels(c);
            [f, ybl] = calc_fft(s,h,class, 1.0, 2.00, channel);
            [f, ymi] = calc_fft(s,h,class, 4, 5, channel);
            [f, yers] = calc_fft(s,h,class, 6.5, 7.5, channel);

            subplot(1, 2, c);
%            plot(f, ybl, f, ymi, f, yers); 
            ymi = (ymi - ybl)./ybl * 100;
            yers = (yers - ybl) ./ ybl * 100;
            plot(f, ymi, f, yers); 
        
            if(channel == 8)
                title('C3');
                ylabel('Percent [%]'); 
            elseif(channel == 12)
                title('C4');
                legend('motor imagery', 'post motor imagery');
            end

%            mx = max(max(abs([ymi; yers])));
%            mx = ceil(m/100)*100;
%            printf('Max amplitude = %d\n', m);
     
            grid on;
            xlim([0 30]);
            ylim([-100, 100]);
            xlabel('Frequency (Hz)');

            save_plot(sprintf('results/eeg_blmiers_%d_%s', subject, classes{class}));
        end
    end
end
