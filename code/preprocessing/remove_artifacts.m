function s_filtered = remove_artifacts(s,h)
    s(isnan(s)) = 0;

    % REDUCE ARTIFACTS - highpass filtering (7-30 Hz)
    fs = h.SampleRate;
    [b,a] = butter(5, [7, 30]/(fs/2));
    s_filtered = filter(b, a, s);
end

