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
params.classifier.type = 'LDA'

final_evaluation(params)
