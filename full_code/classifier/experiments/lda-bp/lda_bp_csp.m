rfile = init_experiment('lda_bp_csp_0');

p = [];

p.trim_low = 3.5;
p.trim_high = 6.0;
p.downsampling = 4;
p.feat = [];
  p.feat.type = 'bp';
  p.feat.bands = [8,14; 20,26];
  p.feat.window = 2;
p.csp = 1;
p.classifier = [];
  p.classifier.type = 'LDA';
single_experiment(p, rfile);

%p.feat.bands = [8,14; 14,20; 20,26; 26,30];
%single_experiment(p, rfile);

%p.feat.bands = [8,12;14,18; 20,24; 26,30];
%single_experiment(p, rfile);
