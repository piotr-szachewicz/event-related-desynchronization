pre = round(3 * fs);
post = round(6 * fs);
gap = 0;
[x,sz] = trigg(f,h.TRIG,pre,post,gap);
%d = reshape(x,sz); % 80 x 751 x 288 - training features

c = h.Classlabel;
train_labels = repmat(c,1,post-pre+1)'(:)';

labels = [];
for i = 1:size(f,2)+1,
%    disp('dafda');
  labels = [labels i];%sprintf('a%d', i)];
end

output = [x' train_labels'];

output = [labels; output];

dlmwrite('weka1.csv', output);
