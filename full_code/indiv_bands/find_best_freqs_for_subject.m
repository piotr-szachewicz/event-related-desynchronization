function [best_freqs, freqs, values] = find_best_freqs_for_subject(subject)
    filename = sprintf('A0%dT_red_bp.gdf', subject);
    [s,h] = load_data(filename);

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

end
