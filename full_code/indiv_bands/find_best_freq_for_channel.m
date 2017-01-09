function [f, v] = find_best_freq_for_channel(s, h, channel)
    ymi = [];
    for class = [1,2,3,4]
	    %printf('Drawing subject %d, class %d, channel %d\n', subject, class, channel);

	    [f, ybl] = calc_fft(s,h,class, 1.0, 2.00, channel);
	    [f, ym] = calc_fft(s,h,class, 4, 5, channel);

	    ym = (ym - ybl)./ybl * 100;

        ymi = [ymi ym];
    end

    classes = [ dif(ymi,1) dif(ymi,2) dif(ymi,3) dif(ymi,4) ];

    %plot(f, classes(:,1))
%    legend('left', 'right', 'feet', 'tongue', 'left discrimination')
%    plot(f, ymi, f, class1)
    f1 = find_best_frequency(classes(:,1));
    f2 = find_best_frequency(classes(:,2));
    f3 = find_best_frequency(classes(:,3));
    f4 = find_best_frequency(classes(:,4));
    
    f = [f1 f2 f3 f4];
    v = [ classes(f1,1) classes(f2,2) classes(f3,3) classes(f4,4)];
end

