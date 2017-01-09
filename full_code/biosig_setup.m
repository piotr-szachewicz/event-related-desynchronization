more off;

if !exist('settings.m', 'file')
    printf('File settings.m does not exist, please create one. Example: settings_example.m');
    return;
end

c = settings();

pkg load signal;
printf("=======================================");
printf("Definining variables: ");
data_directory = get_data_directory();
filename_short = 'A01T.gdf'
filename = strcat(data_directory, filename_short)

addpath(strcat(pwd, '/classifier/'));
addpath(strcat(pwd, '/classifier/experiments/'));
addpath(strcat(pwd, '/utils/'));
addpath(strcat(pwd, '/visualization'));
addpath(strcat(pwd, '/indiv_bands'));
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

