function rfile = init_experiment(results_file)
	
	clear exp_counter; % we need this to clear all the global variables
	run ../../biosig_setup.m

	rfile = strcat('results/', results_file);
	if(exist(rfile, 'file') != 0)
		error('Error - results file already exist!!!!');
	end

	printf('Resetting file %s for experiment\n\n', rfile);
	fid = fopen(rfile, 'w+');
	fclose(fid);
end
