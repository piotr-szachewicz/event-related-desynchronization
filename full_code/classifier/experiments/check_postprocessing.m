rfile = init_experiment('check_postprocessing');

p = [];

p.trim_low = 3.5;
p.trim_high = 5;
p.downsampling = 4;
p.feat = [];
  p.feat.type = 'bp';
  p.feat.bands = [8,12;14,18];
  p.feat.window = 1;
p.csp = 1;
p.classifier = [];
  p.classifier.type = 'LDA';
single_experiment(p, rfile); %1

% Czy normalizacja poprawia 

for c = [10:20:200]
	p.postprocessing = c;
	single_experiment(p, rfile); %2 
end


