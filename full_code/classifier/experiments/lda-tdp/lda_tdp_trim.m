rfile = init_experiment('lda_tdp');

p = [];

p.trim_low = 0;
p.trim_high = 7.5;
p.downsampling = 4;
p.feat = [];
  p.feat.type = 'tdp';
  p.feat.subtype = 'log-power';
  p.feat.d = 9;
  p.feat.u = 0.0085;
%p.csp = 1; % przestrzen cech z TDP jest dosc duza, wiec uzyto CSP, zeby ja zmniejszyc.
p.csp = 0;
p.classifier = [];
p.classifier.type = 'LDA'
%single_experiment(p, rfile);

p.trim_low = 3.0;
p.trim_high = 6.0;
single_experiment(p, rfile);

p.trim_low = 3.5;
p.trim_high = 6.0;
single_experiment(p, rfile);

p.trim_low = 4.0;
p.trim_high = 6.0;
single_experiment(p, rfile);

p.trim_low = 4.0;
p.trim_high = 5.0;
single_experiment(p, rfile);

