rfile = init_experiment('lda_bp_bands_1band');

p = [];

p.trim_low = 3.5;
p.trim_high = 6.0;
p.downsampling = 4;
p.feat = [];
  p.feat.type = 'bp';
  p.feat.bands = [8,12];
  p.feat.window = 2;
p.csp = 0;
p.classifier = [];
  p.classifier.type = 'LDA';
single_experiment(p, rfile);

% jak zwiekszanie liczby pasm wplywa na wyniki

p.feat.bands = [7,12];
single_experiment(p, rfile);

p.feat.bands = [8,11];
single_experiment(p, rfile);

p.feat.bands = [8,13];
single_experiment(p, rfile);

p.feat.bands = [8,14];
single_experiment(p, rfile);

p.feat.bands = [8,15];
single_experiment(p, rfile);

p.feat.bands = [9,14];
single_experiment(p, rfile);

p.feat.bands = [14,18];
single_experiment(p, rfile);

p.feat.bands = [20,24];
single_experiment(p, rfile);

p.feat.bands = [24,28];
single_experiment(p, rfile);


p.feat.bands = [16,20];
single_experiment(p, rfile);

p.feat.bands = [18,22];
single_experiment(p, rfile);

p.feat.bands = [22,26];
single_experiment(p, rfile);

p.feat.bands = [26,30];
single_experiment(p, rfile);

