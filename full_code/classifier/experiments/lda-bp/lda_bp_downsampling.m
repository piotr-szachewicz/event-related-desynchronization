rfile = init_experiment('lda_bp_downsampling');

p = [];

p.trim_low = 3.5;
p.trim_high = 6.0;
p.downsampling = 1;
p.feat = [];
  p.feat.type = 'bp';
  p.feat.bands = [8,12;14,18];
  p.feat.window = 1;
p.csp = 0;
p.classifier = [];
  p.classifier.type = 'LDA';
single_experiment(p, rfile);

p.downsampling = 2;
single_experiment(p, rfile);

p.downsampling = 3;
single_experiment(p, rfile);

p.downsampling = 4;
single_experiment(p, rfile);

p.downsampling = 5;
single_experiment(p, rfile);

p.downsampling = 6;
single_experiment(p, rfile);
