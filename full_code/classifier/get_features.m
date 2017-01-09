function [f, h, p, csp_matrix] = get_features(file = 'A09T_red.gdf', p = [], classlabels=[])

    % 0. LOAD DATA
    printf('### Loading data from file %s...\n', file);

    [s,h,filename] = load_data(file);
    
    if !isempty(classlabels)
        printf('setting new classlabels \n');
        h.Classlabel = classlabels;
    end

    printf('Input signal size: %d x %d\n', size(s,1), size(s,2));

    eegchan = 1:22;
    s = s(:, eegchan);
    s(isnan(s)) = 0;

    if strcmp(p.feat.type, 'bp')
        printf('Features: calculating bands for bandpower\n');

        if(isempty(p.feat.bands))
      	    csp_matrix = multiclass_csp(s,h,p); %TODO - CSP tylko na trimie
            ss = s * csp_matrix;
	    printf('Finding individual frequency bands\n');
            p.feat.bands = find_individual_frequency_bands(1, ss, h)
        end
    end

    % downsampling
    fprintf(1,'\tc: resampling (factor = %d).\n', p.downsampling);
    DIV = p.downsampling;
    s = rs(s,DIV,1);   % downsampling by a factor of DIV; 
    %s = rs(s,250,100); % downsampling from 256 to 100 Hz. 
    h.SampleRate = h.SampleRate/DIV;
    h.EVENT.POS = round(h.EVENT.POS/DIV);
    h.EVENT.DUR = round(h.EVENT.DUR/DIV);
    h.TRIG      = round(h.TRIG/DIV);
    fs = h.SampleRate;

    %--------- extraction from event table 
    printf('\tb: Extract trigger and classlabels.\n');
    ix = find((h.EVENT.TYP>hex2dec('300'))&(h.EVENT.TYP<=hex2dec('30f'))); % 0x0300..0x03ff
    t0 = h.EVENT.POS(ix);
    t0 = (t0(1) - h.TRIG(1))/h.SampleRate;  % time between trial start and cue;
 
    % 1. PREPROCESSING

    % a/ bandpass filter everything
    %[b,a] = butter(5, [8,15]/(fs/2));
    %s1 = filter(b,a,s);

    %[b,a] = butter(5, [15,30]/(fs/2));
    %s2 = filter(b,a,s);

    % b/ spatial filters
    if p.csp == 1

% filterin to a specific frequency band before using CSP
%	if(strcmp(p.feat.type, 'bp')==0)
%		bnd = p.feat.bands;
%		printf('Filtering a band for CSP\n');
%		[b,a] = butter(5, bnd/(fs/2));
%		s = filter(b,a,s);
%	end

        printf('RUNNING CSP\n');
        if fieldexists(p, 'csp_matrix')
            printf('Taking CSP matrix from paramers.\n')
            csp_matrix = p.csp_matrix;
        else
            printf('Calculating new CSP matrix\n');
            csp_matrix = multiclass_csp(s,h,p );
        end
        s = s * csp_matrix;
    end
    %s2 = multiclass_csp(s2,h);

    % 2. FEATURE EXTRACTION
    fprintf(1,'\tc: Feature exraction.\n');

    if strcmp(p.feat.type, 'bp')
        printf('Features: Bandpower\n');
        win = p.feat.window;    % length of smoothing window in seconds
        bands = p.feat.bands;

        f = bandpower(s, h.SampleRate, bands, win);
    elseif strcmp(p.feat.type, 'tdp')
        printf('Features: tdp\n');
        d = p.feat.d;
        u = p.feat.u;
        [ff, gg] = tdp(s, d, u);
	    if (strcmp(p.feat.subtype, 'log-power'))
		    f = ff;
    	elseif strcmp(p.feat.subtype, 'log-amplitude')
    		f = gg;
    	elseif strcmp(p.feat.subtype, 'log-power+log-amplitude')
    		f = [ff, gg];
        end
    elseif strcmp(p.feat.type, 'both')
        printf('Features: both\n');
        f_tdp = tdp(s, p.feat.d, p.feat.u);

        f_bp = bandpower(s, h.SampleRate, p.feat.bands, p.feat.window);
        f = [f_tdp, f_bp]; %TODO - czy to na pewno jest dobrze polaczone?
        printf('STD DEV --- FEATS: \n');
        mean(f)
        std(f)
    end

    if(fieldexists(p, 'normalize') && p.normalize == 1)
	    printf('Normalize features\n');
	    f = (f - mean(f)) ./ std(f);
    end

    printf('Feature set size: %d x %d\n', size(f,1), size(f,2));

end
