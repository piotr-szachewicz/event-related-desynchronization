rfile = init_experiment('lr_bp');

p = [];

p.trim_low = 4;
p.trim_high = 5.0;
p.downsampling = 4;
p.feat = [];
p.feat.type = 'bp';
p.feat.bands = [8,12;14,18];
p.feat.window = 0.5;
p.csp = 1;
p.classifier = [];
p.classifier.type = 'lr'
p.classifier.kernel = 'linear'
%p.classifier_params.kernel_width = 5.0 %gaussian

%sets = 2.^[-16:4:16];
sets = 2.^[4:4:16];
for c = sets
	%[1.0, 0.1, 0.01, 0.001]dd
	p.classifier.C = c;
	single_experiment(p, rfile);
end
