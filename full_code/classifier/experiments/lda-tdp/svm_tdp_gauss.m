rfile = init_experiment('svm_tdp_gauss_2');

p = [];

p.trim_low = 4.0;
p.trim_high = 6.0;
p.downsampling = 4;
p.feat = [];
p.feat.type = 'tdp';
p.feat.subtype='log-power';
p.feat.d=5;
p.feat.u=0.015;
p.csp = 1;
p.classifier = [];
p.classifier.type = 'svm'
p.classifier.kernel = 'gaussian'

p.classifier.kernel = 'gaussian';
for w = [1e1 1e2 1e3 1e4 1e5]
%   for c = [1e-2 1e-1 1 10 1e2 1e3]
for c = [1e4]
      p.classifier.kernel_width = w;
      p.classifier.C = c;
      single_experiment(p, rfile);
   end
end

