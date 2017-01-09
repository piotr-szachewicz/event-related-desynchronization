% Classyfying ERD data.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

filename = 'A01T.gdf';

fprintf(1,'1: Load data.\n',filename);
[s,h]=sload(filename);
fs = h.SampleRate;

eegchan = 1:22;
s = s(:, eegchan);
s(isnan(s)) = 0; % NaN samples are disasterous for IIR filtering

% PREPROCESSING
fprintf(1, '2: Preprocessing\n');

fprintf(1, '\tRemoving artifacts using a 7-30 Hz bandpass filter\n');
[b,a] = butter(5, [7, 30]/(fs/2));
s = filter(b,a,s);

fprintf(1, '\tApplying CSP\n');
csp_matrix = multiclass_csp(s,h,p);
s = s * csp_matrix;

fprintf(1, '\tDownsampling\n');
s = rs(s, 4, 1);   % downsampling by a factor of DIV; 
h.SampleRate = h.SampleRate/DIV;
h.EVENT.POS = round(h.EVENT.POS/DIV);
h.EVENT.DUR = round(h.EVENT.DUR/DIV);
h.TRIG      = round(h.TRIG/DIV);
fs = h.SampleRate;

% FEATURE EXTRACTION


% CLASSIFICATION
