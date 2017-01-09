% example - how to reduce EOG artifacts.
function reduce_artifacts(filename)

printf('tetestest\n');


printf('Loading file %s\n', filename)
[s,h] = load_data(filename);%sload(filename);
s(isnan(s)) = 0;
s_original = s;

% REDUCE ARTIFACTS - highpass filtering

fs = h.SampleRate;
[b,a] = butter(5, [7, 30]/(fs/2));
s_filtered = filter(b,a,s);

% REDUCE ARTIFACTS - linear regression
eogchan=identify_eog_channels(strcat(get_data_directory, filename));
% eogchan can be matrix in order to convert 
%     monopolar EOG to bipolar EOG channels
eegchan=find(h.CHANTYP=='E'); % exclude any non-eeg channel. 
R = regress_eog(s,eegchan,eogchan); 
s = s*R.r0;    % reduce EOG artifacts

% DRAW PLOTS
start = 1570; 

length_sec = 10;
first_sample = h.SampleRate * start;
last_sample = first_sample + h.SampleRate * length_sec; % 10 sec. length
t = start:1/h.SampleRate:(start+length_sec);

channels = [23, 24, 25];
xrange = first_sample:last_sample;

y = s_original(xrange, 1);
titles = [ h.Label{1} ];
y = [ y s_filtered(xrange, 1)];
%titles = [ titles ; strcat(h.Label{1}, ' (after EOG reduction)') ];
titles = { "contaminated", "filtered", "EOG-L", "EOG-C", "EOG-R"};

for i = 1:3
    ch = channels(i);
    y = [ y s_original(xrange, ch) ];
%    titles = [ titles ; h.Label{ch} ];
end

plot_data(t, y, titles, [-180, 250]);
save_plot('eog_reduction');

% SAVE EOG-REDUCED FILE
%new_file_name = strcat(strsplit(h.FileName, "."){:,1}, "_red.gdf");
%save_signal(h, s, new_file_name);
new_file_name = strcat(strsplit(h.FileName, "."){:,1}, "_red_bp.gdf");
save_signal(h, s_filtered, new_file_name);

end
