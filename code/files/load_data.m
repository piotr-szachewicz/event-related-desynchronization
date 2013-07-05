function [s,h, filename] = load_data(file = 'A01T.gdf')
    data_directory = get_data_directory();
    filename = strcat(data_directory, file);
    printf('Loading data... from %s please wait\n', filename);
    [s, h] = sload(filename);
    printf('Data loaded\n');
end
