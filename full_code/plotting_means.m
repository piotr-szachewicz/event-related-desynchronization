file = '/home/kret/repositories/erders/data/2a/A01T_red.gdf';

R=evoked_potential(file, [1:25], -2, 5.5, 771);
plota(R);
print -dpng mean_foot.png

R=evoked_potential(file, [1:25], -2, 5.5, 772);
plota(R);
print -dpng mean_tongue.png

R=evoked_potential(file, [1], -2, 5.5, 771);
plota(R);
print -dpng mean_foot_Fpz.png

R=evoked_potential(file, [1], -2, 5.5, 772);
plota(R);
print -dpng mean_tongue_Fpz.png


