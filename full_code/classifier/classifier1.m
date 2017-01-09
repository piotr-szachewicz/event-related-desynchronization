%run get_features.m

% adding features that happened 3 seconds before to the current feature vector.
%previous = [nan(round(fs*3),80); f((round(fs*3)+1):end,:)];
%f = [f previous];

% CLASSIFICATION -- using BioSig

fprintf(1,'Step 4: classification.\n');
TrialLen = 7.5; % seconds
SegmentLen = 100; % samples
NoS = ceil(TrialLen*h.SampleRate/SegmentLen);
MODE.T   = reshape((1:NoS*SegmentLen),SegmentLen,NoS)';
% valid segments for building classifier must be after cue.
MODE.WIN = MODE.T(:,1) > t0*h.SampleRate+1;    % cue @ t=2s.
MODE.t0= t0;
MODE.t = [min(MODE.T(:)):max(MODE.T(:))]'/h.SampleRate;
MODE.Segments = MODE.T;
MODE.Fs = h.SampleRate;

%%%% X-V based on Jackknife-procedure (leave-K-trials-out)
K = 1;
NG = ceil([1:length(h.Classlabel)]'/K);

TYPE.TYPE = 'LDA';  % classifier type 
% TYPE.hyperparameters.gamma = 0;   % and its hyperparameters
% other possible classifiers are: MDA, LD2, LD3, LD4, RDA, GDBC, SVM, RBF, NBC, aNBC, LDA/GSVD, MDA/GSVD, LDA/sparse, MDA/sparse 

% search best segment, cross-validation using jackknife procedure, 1-vs-rest classifier 
CC1 = findclassifier(f, h.TRIG, [h.Classlabel,NG], MODE, [], TYPE);

