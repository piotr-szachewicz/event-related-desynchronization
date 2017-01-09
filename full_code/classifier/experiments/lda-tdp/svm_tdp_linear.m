rfile = init_experiment('svm_tdp_linear');

p = [];

p.trim_low = 4.0;
p.trim_high = 6.0;
p.downsampling = 4;
p.feat = [];
p.feat.type = 'tdp';
p.feat.subtype = 'log-power';
p.feat.d = 5;
p.feat.u = 0.015;
p.csp = 1;
p.classifier = [];
p.classifier.type = 'svm'
p.classifier.kernel = 'linear';
p.classifier.kernel_width = 5;

% testowanie liniowego kernela dla roznych C
for c = [10000, 1000, 100, 10, 1.0, 0.1, 0.01, 0.001, 0.0001]
	p.classifier.C = c;
	single_experiment(p, rfile);
end

% testowanie Gaussowskiego kernela dla C = 1.0, zmieniamy wielkość kernela.
%p.classifier.C = 1.0;
%p.classifier.kernel = 'gaussian';
%for w = [5, 10, 15, 20, 25]
%	p.classifier.kernel_width = w;
%	single_experiment(p, rfile);
%end

