function rysuj_erds(file, clazz)
%file = '/home/kret/repositories/erders/data/2a/A02T.gdf';

%load signal
%[s,h] = load_data('A01T_red.gdf');
[s,h] = load_data(file);
s(isnan(s)) = 0;

%params
name = 'sample22'
channels = 1:22;  % 0 ... All channels
classes = [clazz];  % [] ... All classes
method = 'bp';  % 'bp' or 'fft'
refmethod = 'classic';  % 'classic' or 'trial'
fs = h.SampleRate;


%% ERDS maps
%r1 = calcErdsMap(s(:,1:4), h, [0, 0.0, 7.5], [5, 40], 'method', method, 'class', classes, 'ref', [0.75, 1.25], 'f_bandwidths', [2], 'f_steps', [1], 'sig', 'boxcox', 'lambda', 1, 'alpha', 0.05, 'heading', name, 'montage', [1 1 1 1], 'cue', 2, 'refmethod', refmethod);
%plotErdsMap(r1);
s = s(:, 1:22);


%p=[];
%p.trim_low = 3.5;
%p.trim_high = 6.0;
%csp_matrix = multiclass_csp(s,h,p);
%s = s * csp_matrix;


%% Combination of ERDS maps and average/variance
r3 = calcErdsMap(s(:,:), h, [0, 0.0, 7.5], [5, 30], 'method', method, 'class', classes, 'ref', [1.0, 1.5], 'f_bandwidths', [2], 'cue', 2);
plotErdsMap(r3);

%plot_name = sprintf('%s-%d.eps', strsplit(h.FileName, "."){:,1}, clazz);
%printf('Saving as %s\n', plot_name);
%print(plot_name, '-depslatex', '-S930,700', '-F:4');
%print(sprintf('%s_%d_map.png',file,clazz));

end
