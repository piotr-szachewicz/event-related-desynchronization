rfile = init_experiment('lda_tdp_u');

p = [];

p.trim_low = 4.0;
p.trim_high = 6.0;
p.downsampling = 4;
p.feat = [];
  p.feat.type = 'tdp';
  p.feat.subtype = 'log-power';
  p.feat.d = 5;
  p.feat.u = 0.0085;
%p.csp = 1; % przestrzen cech z TDP jest dosc duza, wiec uzyto CSP, zeby ja zmniejszyc.
p.csp = 1;
p.classifier = [];
p.classifier.type = 'LDA'
%single_experiment(p, rfile);

%sfor i = [0.1:0.1:1]
%for i = [0.0001:0.01:0.1]
for i = [0.0001 0.005, 0.01 0.0125, 0.015, 0.0175 0.2:0.1:1.0]
	p.feat.u = i;
	single_experiment(p, rfile);
end

%p.downsampling = 4;
%single_experiment(p, rfile);

%p.downsampling = 4;
%p.csp = 1;
%single_experiment(p, rfile);

