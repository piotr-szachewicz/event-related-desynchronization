rfile = init_experiment('lda_bp');

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

p.trim_low = 3;
p.trim_high = 6.5;
single_experiment(p, rfile); %4

p.trim_low = 3.5;
p.trim_high = 6.0;
single_experiment(p, rfile); %5

p.trim_low = 4;
p.trim_high = 5.5;
single_experiment(p, rfile); %5

p.trim_low = 4.5;
p.trim_high = 5;
single_experiment(p, rfile); %5


% jak zwiekszanie/zmniejszanie okna wplywa

p.feat.window = 0.5;
single_experiment(p, rfile); %2 

p.feat.window = 1.5;
single_experiment(p, rfile); %3

p.feat.window = 2;
single_experiment(p, rfile); %3

p.feat.window = 2;
single_experiment(p, rfile); %3
% 2 eksperymenty -- jak czas przyciecia wplywa na wyniki



% jak downsampling wplywa na wyniki
p.downsampling = 2;
single_experiment(p, rfile);%6

p.downsampling = 4;
single_experiment(p, rfile);%7

p.downsampling = 6;
single_experiment(p, rfile);%8

% jak zwiekszanie liczby pasm wplywa na wyniki
p.downsampling = 4;
p.feat.bands = [8,12;14,18; 20,24];
single_experiment(p, rfile);

p.feat.bands = [8,12;14,18; 20,24; 26,30];
single_experiment(p, rfile);

% jak uzycie CSP wplywa
p.csp = 1;
single_experiment(p, rfile);


%p.feat_arg = [8,12;14,18; 20,24; 26,30]; % wiesza sie z braku pamieci
%single_experiment(p, rfile);

