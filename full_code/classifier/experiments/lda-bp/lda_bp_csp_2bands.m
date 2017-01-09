rfile = init_experiment('lda_bp_csp_2bands');

p = [];

p.trim_low = 3.5;
p.trim_high = 6.0;
p.downsampling = 4;
p.feat = [];
  p.feat.type = 'bp';
  p.feat.window = 2;
p.csp = 1;
p.classifier = [];
  p.classifier.type = 'LDA';
%single_experiment(p, rfile);

% jak zwiekszanie liczby pasm wplywa na wyniki

p.feat.bands = [8,15;16,20];
single_experiment(p, rfile);

p.feat.bands = [8,15;18,22];
single_experiment(p, rfile);

p.feat.bands = [8,15;20,24];
single_experiment(p, rfile);

p.feat.bands = [8,15;22,26];
single_experiment(p, rfile);

p.feat.bands = [8,15;24,28];
single_experiment(p, rfile);

p.feat.bands = [8,15;26,30];
single_experiment(p, rfile);

p.feat.bands = [8,15;20,25];
single_experiment(p, rfile);

p.feat.bands = [8,15;20,23];
single_experiment(p, rfile);

p.feat.bands = [8,15;19,23];
single_experiment(p, rfile);

p.feat.bands = [8,15;19,24];
single_experiment(p, rfile);

p.feat.bands = [8,15;19,25];
single_experiment(p, rfile);


p.feat.bands = [8,15;21,23];
single_experiment(p, rfile);

p.feat.bands = [8,15;21,24];
single_experiment(p, rfile);

p.feat.bands = [8,15;21,25];
single_experiment(p, rfile);

