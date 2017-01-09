function [dir] = get_data_directory()
    c = settings();
    dir = strcat(c.ERDRS_PATH, 'data/2a/');
end

