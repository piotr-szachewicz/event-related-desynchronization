rfile = init_experiment('lda_tdp_derivatives');

p = [];

p.trim_low = 4.0;
p.trim_high = 6.0;
p.downsampling = 4;
p.feat = [];
  p.feat.type = 'tdp';
  p.feat.subtype = 'log-power';
  p.feat.d = 9;
  p.feat.u = 0.0085;
p.csp = 1;
p.classifier = [];
p.classifier.type = 'LDA'

for i = [1:12]
	p.feat.d = i;
	single_experiment(p, rfile);
end

