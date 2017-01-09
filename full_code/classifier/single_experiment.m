function [results] = single_experiment(params, results_filename = '')

global exp_counter=1;

printf('Running single experiment for data: \n');
params

start_time = cputime();

kap = [];
max_times = [];
train_kap = [];
cv_kap = [];
all_kap = [];

for i = 1:9,
    file = sprintf('A0%dT_red_bp.gdf', i);
    [f,h, params, cspmatrix] = get_features(file, params);
    
%    if !isempty(results_filename)
%        fid = fopen(results_filename, 'a')
%        vs = sprintf('%d, ', params.feat.bands);
%	vs = strcat('[', vs, ']');

%       fprintf(fid, '%%subject %d frequencies %s:\n', i, vs);

%       fclose(fid);
%    end 

    rk = [];
    tk = [];
    for j = 1:1, %how many times we perform cv on one set
        printf('   CV ROUND %d WITH %s\n', j, file);
        run ../classifier2kfold.m
        rk = [ rk real_kappa ];
        tk = [ tk mean(train_kappas) ];
    end
    rk = mean(rk);
    tk = mean(tk);

    kap = [ kap rk ];
%    max_times = [ max_times max_time ];
    train_kap = [ train_kap tk ];
    cv_kap = [ cv_kap mean(test_kappas) ];
    
%    all_kap = [ all_kap all_kappas ];
end

disp('============================================================');

printf('Feature set size: %d x %d\n', size(f,1), size(f,2));

disp('Kappa values from all experiments: \n');
kap

printf('Train kappas: (mean: %f)\n', mean(train_kap));
train_kap

printf('Crossvalidation kappas: (mean %f)\n', mean(cv_kap));
cv_kap

disp('Max times from all experiments: \n');
max_times

printf('Mean kappa value: %f\n', mean(kap));

end_time = cputime();
dt = end_time - start_time;

printf('Experiment lasted for %f seconds\n', dt);
dt = dt / 60;
printf('Experiment lasted for %f minutes\n', dt);

printf('-----------------------------------------');
printf('-----------------------------------------');
printf('OUTPUT for LATEX\n');

x = [ mean(train_kap) mean(kap) ];
%x = [ mean(train_kap) mean(kap) kap dt ];

s = sprintf('$%d$&', exp_counter);
exp_counter++;
s = strcat(s, sprintf('%d&', size(f,2)));

for i = 1:size(x,2)
	if i == 2	
		s = strcat(s, sprintf('$\\bm{%.2f}$',x(i)));
	else	
		s = strcat(s, sprintf('$%.2f$',x(i)));
	end

	if i < size(x,2)
		s = strcat(s, '&');
	else
		s = strcat(s, '\tabularnewline');
	end
end

printf('%s', print_struct(params));
printf('%s', s);
printf('\n\n\n');

results = s;
%fprintf(fid, '%s', params);

if !isempty(results_filename)
    fid = fopen(results_filename, 'a')
    fprintf(fid, '%% %s:\n', print_struct(params));
    fprintf(fid, '%s\n', s);
    fclose(fid);
end

%plotting kappa time courses
%return
return
for i = 1:9,
    %plot
    subplot(3,3,i);
    t = (1:size(all_kap(:,i),1)) / h.SampleRate;
    plot(t, all_kap(:,i));
    title(sprintf('subject %d', i));

    if(i == 7 || i == 8 || i == 9)
        xlabel('time [s]');
    end
    if(i == 1 || i == 4 || i == 7)
        ylabel(sprintf('kappa value', i));
    end
end

end
