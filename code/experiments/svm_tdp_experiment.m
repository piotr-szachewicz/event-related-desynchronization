run ../biosig_setup.m

params = [];

params.trim_low = 4.0;
params.trim_high = 6;
params.downsampling = 4;
params.feat = [];
  params.feat.type = 'tdp';
  params.feat.subtype = 'log-power';
  params.feat.u = 0.015;
  params.feat.d = 5;
  params.feat.window = 2;
params.csp = 1;
params.classifier = [];
params.classifier.type = 'svm';
params.classifier.kernel = 'gaussian';
params.classifier.kernel_width = 100;
params.classifier.C = 100;

final_evaluation(params)
