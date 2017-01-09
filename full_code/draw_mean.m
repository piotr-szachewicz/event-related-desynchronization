run biosig_setup.m;

R=evoked_potential(file, [1:2], -2, 5.5, 769);
plota(R);


% Reszte wyrzucic.

[s,h] = load_data(filename_short);

printf('signal size:\n');
size(s)

sample_rate = h.SampleRate;
start_event = 768
left_event = 769
right_event = 770
foot_event = 771
tongue_event = 772
rejected_trial = 1023

ids = find(h.EVENT.TYP==right_event);
start_samples = h.EVENT.POS(ids);
offset_left = sample_rate * 2; % start averaging 2 seconds before cue onset 
trial_length = sample_rate * 7.5; % whole trial is 7.5 seconds long

N = size(ids,1);
N_used = 0;
val = zeros(trial_length, size(s,2));
for i = 1:N,
    if (h.EVENT.TYP(ids(i)-1) == rejected_trial)
        printf('This trial was rejected by an expert %d\n', ids(i));
        continue
    end

    sig = s(start_samples(i)-offset_left:start_samples(i)-offset_left+trial_length-1,:);
    if max(max(isinf(sig))) > 0 || max(max(isnan(sig))) >0
        continue;
        printf('AAAAAAAAAAAAAAAA %d\n', i);
    end
    N_used += 1;
    val += sig;
end
val /= N_used;


% Drawing plots

t = (1:size(val,1)) / sample_rate;

channels_N = 25;
titles = [];
for i = 1:channels_N
    label = sprintf('channel %d (%s)', i, h.Label{i});
    titles = [ titles ; label ];
end

plot_data(t, val, titles, [-20, 20], 'seconds', 'uV', 1, [1:7], [-20, 0, 20]);
%save_plot('erp');

print -dpng mean_plots.png

