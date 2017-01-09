function best_bands = find_individual_frequency_bands(subject, s=[], h=[])
    if(isempty(s))
	printf('Find individual freq - load signal\n');
        filename = sprintf('A0%dT_red_bp.gdf', subject);
        [s,h] = load_data(filename);
    end

    freqs = [];
    values = [];
    for channel = 1:size(s,2)
        [fc, vc] = find_best_freq_for_channel(s,h,channel);
        freqs = [ freqs ; fc];
        values = [ values ; vc];
    end

    [v,i] = max(freqs);
    size(freqs)
    freqs

    best_freqs = [];
    for j=1:4
       best_freqs = [ best_freqs freqs(i(j), j) ];
    end
    best_freqs = [best_freqs mode(freqs)];
    best_freqs = unique(best_freqs);
    best_freqs

    fbest = [];
    for i=1:length(best_freqs)
        fr = best_freqs(i);
        if (isempty(find(fbest == fr+1)) && isempty(find(fbest == fr-1)))
	    fbest = [fbest fr];
        end
    end
    best_freqs = fbest

    if(length(best_freqs)>3)
        best_freqs = best_freqs(1:3);
    end

    best_bands = []
    for freq=best_freqs
        best_bands = [best_bands ; freq-2 freq+2];
    end


end

%[best, freqs, values ] =find_best_freqs_for_subject(1)
