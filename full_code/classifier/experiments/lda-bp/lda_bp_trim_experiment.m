rfile = init_experiment('lda_bp_trim');

p = [];

p.trim_low = 0;
p.trim_high = 7.5;
p.downsampling = 1;
p.feat = [];
  p.feat.type = 'bp';
  p.feat.bands = [8,12;14,18];
  p.feat.window = 1;
p.csp = 0;
p.classifier = [];
  p.classifier.type = 'LDA';
single_experiment(p, rfile); %1

return
p.trim_low = 3;
p.trim_high = 6.5;
single_experiment(p, rfile); %2

p.trim_low = 3.5;
p.trim_high = 6.0;
single_experiment(p, rfile); %3

p.trim_low = 3.5;
p.trim_high = 7.5;
single_experiment(p, rfile); %3

p.trim_low = 3.5;
p.trim_high = 7;
single_experiment(p, rfile); %3

p.trim_low = 4.0;
p.trim_high = 6.0;
single_experiment(p, rfile); %3

p.trim_low = 4;
p.trim_high = 5.5;
single_experiment(p, rfile); %4

p.trim_low = 4;
p.trim_high = 5;
single_experiment(p, rfile); %4

p.trim_low = 4.5;
p.trim_high = 5;
single_experiment(p, rfile); %5

