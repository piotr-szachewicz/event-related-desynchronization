function save_plot(filename)
    %full_name = strcat('~/repositories/erders/thesis/figures/', filename);
    %printf('Saving plot to %s\n', full_name);
%    print -depslatex "-S930,700" $full_name;
%    print(full_name, '-depslatex', '-S930,700', '-F:4');
%    print(full_name, '-dpng')%, '-S930,700', '-F:4');
    print(strcat(filename, '.png'))
end
