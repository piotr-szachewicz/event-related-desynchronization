rfile = init_experiment('lda_bp_bands_2bands_v2');

p = [];

p.trim_low = 3.5;
p.trim_high = 6.0;
p.downsampling = 4;
p.feat = [];
  p.feat.type = 'bp';
  p.feat.bands = [8,14;14,18];
  p.feat.window = 2;
p.csp = 0;
p.classifier = [];
  p.classifier.type = 'LDA';
%single_experiment(p, rfile);

% jak zwiekszanie liczby pasm wplywa na wyniki

%p.feat.bands = [8,14;21,25];
%single_experiment(p, rfile);

p.feat.bands = [8,14;22,25];
single_experiment(p, rfile);

p.feat.bands = [8,14;21,24];
single_experiment(p, rfile);

p.feat.bands = [8,14;20,26];
single_experiment(p, rfile);

%p.feat.bands = [8,14;21,25];
%single_experiment(p, rfile);

