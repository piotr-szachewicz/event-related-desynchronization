function f = find_best_frequency(class)

    peaks_idx = [];
    d = diff(class);
    for i = 2:length(d)
        if(d(i-1) > 0 && d(i) < 0)
            peaks_idx = [peaks_idx i];
        end
    end
    
    peaks_idx = peaks_idx(find(and(peaks_idx > 5, peaks_idx < 30)));
    v = max(class(peaks_idx));
    best_frequency = find(class == v)-1;

    f = best_frequency;
end

