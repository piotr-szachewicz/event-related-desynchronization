rfile = init_experiment('lda_bp_indiv');

p = [];

p.trim_low = 4;
p.trim_high = 5.0;
p.downsampling = 4;
p.feat = [];
  p.feat.type = 'bp';
  p.feat.window = 1;
  p.feat.bands = []; %individual
p.csp = 0;
p.classifier = [];
  p.classifier.type = 'LDA';
single_experiment(p, rfile); %1

% jak zwiekszanie/zmniejszanie okna wplywa

  p.feat.bands = [8,12;14,18];
single_experiment(p, rfile); %2 


