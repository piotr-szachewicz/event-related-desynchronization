rfile = init_experiment('lda_bp_smoothing');

p = [];

p.trim_low = 3.5;
p.trim_high = 6.0;
p.downsampling = 4;
p.feat = [];
  p.feat.type = 'bp';
  p.feat.bands = [8,12;14,18];
  p.feat.window = 0.5;
p.csp = 0;
p.classifier = [];
  p.classifier.type = 'LDA';
single_experiment(p, rfile);

p.feat.window = 1;
single_experiment(p, rfile);

p.feat.window = 1.5;
single_experiment(p, rfile);

p.feat.window = 2.0;
single_experiment(p, rfile);

p.feat.window = 2.5;
single_experiment(p, rfile);

p.feat.window = 3.0;
single_experiment(p, rfile);


