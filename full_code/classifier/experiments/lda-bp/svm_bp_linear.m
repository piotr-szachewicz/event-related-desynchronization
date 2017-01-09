rfile = init_experiment('svm_bp_linear');

p = [];

p.trim_low = 3.5;
p.trim_high = 6.0;
p.downsampling = 4;
p.feat = [];
p.feat.type = 'bp';
p.feat.bands = [9,14;14,20; 20,26];
p.feat.window = 2;
p.csp = 1;
p.classifier = [];
p.classifier.type = 'svm'
p.classifier.kernel = 'linear'
%p.classifier_params.kernel_width = 5.0 %gaussian

%sets = 2.^[-16:4:16];
%sets = 2.^[4:4:16];
sets = [100000, 10000, 1000, 100, 10, 1, 0.1, 0.01, 0.001]
for c = sets
	%[1.0, 0.1, 0.01, 0.001]dd
	p.classifier.C = c;
	single_experiment(p, rfile);
end
