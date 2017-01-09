filename = 'A02T'

for i = 1:9,
    filename = sprintf('A0%dT.gdf', i);
    disp('Start in file: ');
    disp(filename);
    reduce_artifacts(filename);
%    run reduce_artifacts.m;
end
