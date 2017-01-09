rfile = init_experiment('svm_bp_gauss');

p = [];

p.trim_low = 3.5;
p.trim_high = 6.0;
p.downsampling = 4;
p.feat = [];
p.feat.type = 'bp';
p.feat.bands = [8,15;19,24;24,30];
p.feat.window = 2;
p.csp = 1;
p.classifier = [];
p.classifier.type = 'svm'
p.classifier.kernel = 'linear'

%sets = 2.^[-16:4:16];
%sets = 2.^[4:4:16];
%sets = [100000, 10000, 1000, 100, 10, 1, 0.1, 0.01]
%for c = sets
	%[1.0, 0.1, 0.01, 0.001]dd
%	p.classifier.C = c;
%	single_experiment(p, rfile);
%end


% testowanie Gaussowskiego kernela dla C = 1.0, zmieniamy wielkość kernela.
p.classifier.kernel = 'gaussian';
for w = [10 100 1e3 1e4 1e5]
    %[1 1e4]%[10, 100, 1000]
   for c = [1e-2, 1e-1, 1, 1e1, 1e2, 1e3]
      p.classifier.kernel_width = w;
      p.classifier.C = c;
      single_experiment(p, rfile);
   end
end

