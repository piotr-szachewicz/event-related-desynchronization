
for i = 1:9,
    filename = sprintf('A0%dT_red_bp.gdf', i);
    disp('Start in file: ');
    disp(filename);
%    reduce_artifacts(filename);
    rysuj_erds(filename, 1);
%    run reduce_artifacts.m;
end
