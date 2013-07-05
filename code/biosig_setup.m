more off;

if !exist('settings.m', 'file')
    printf('File settings.m does not exist, please create one. Example: settings_example.m');
    return;
end

c = settings();

pkg load signal;

printf("====================== SETTING PATHS ======================\n")

addpath(strcat(pwd, '/classifier/'));
addpath(strcat(pwd, '/evaluation/'));
addpath(strcat(pwd, '/experiments/'));
addpath(strcat(pwd, '/features/'));
addpath(strcat(pwd, '/files/'));
addpath(strcat(pwd, '/preprocessing/'));
addpath(strcat(pwd, '/utils/'));

addpath(pwd);

% if it already exist, we don't install biosig once again.
if exist('sload')
    return
end

printf("====================== LOADING BIOSIG ======================\n")
cd(c.BIOSIG_PATH);
run install.m
cd(strcat(c.ERDRS_PATH,'code/'));
printf("============================================================\n")

