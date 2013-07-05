run ../biosig_setup.m

params = [];

params.trim_low = 3.5;
params.trim_high = 6;
params.downsampling = 4;
params.feat = [];
  params.feat.type = 'bp';
  params.feat.bands = [8,14;19,24;24,30];
  params.feat.window = 2;
params.csp = 1;
params.classifier = [];
params.classifier.type = 'LDA'

final_evaluation(params)
