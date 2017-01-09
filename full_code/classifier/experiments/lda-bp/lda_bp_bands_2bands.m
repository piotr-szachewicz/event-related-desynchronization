rfile = init_experiment('lda_bp_bands_2bands');

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

p.feat.bands = [8,14;16,20];
%single_experiment(p, rfile);

p.feat.bands = [8,14;18,22];
%single_experiment(p, rfile);

p.feat.bands = [8,14;20,24];
%single_experiment(p, rfile);

p.feat.bands = [8,14;21,25];
single_experiment(p, rfile);

p.feat.bands = [8,14;22,26];
%single_experiment(p, rfile);

p.feat.bands = [8,14;24,28];
%single_experiment(p, rfile);

p.feat.bands = [8,14;26,30];
%single_experiment(p, rfile);

% jak uzycie CSP wplywa
%p.csp = 1;
%ingle_experiment(p, rfile);


%p.feat_arg = [8,12;14,18; 20,24; 26,30]; % wiesza sie z braku pamieci
%single_experiment(p, rfile);

