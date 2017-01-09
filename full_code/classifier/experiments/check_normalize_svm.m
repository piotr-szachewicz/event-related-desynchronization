rfile = init_experiment('check_normalize_svm');

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
p.classifier.type = 'svm'
p.classifier.kernel = 'linear'
p.classifier.C = 0.0001
%p.classifier_params.kernel_width = 5.0 %gaussian

single_experiment(p, rfile);
p.normalize = 1;
single_experiment(p, rfile);
