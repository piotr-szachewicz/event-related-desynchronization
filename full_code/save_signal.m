function save_signal(h, s, filename)
    printf('Saving EOG corrected data to a new file: %s\n', filename);
    h.FileName = filename;
    h = sopen(h, 'w');
    h = swrite(h, s);
    sclose(h);
end
