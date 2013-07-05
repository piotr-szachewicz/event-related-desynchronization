function [train_feats, test_features, train_labels, test_labels] = get_data(i, indexes, h, f, K, N, pre, post)
    fs = h.SampleRate;
    pre = round(pre * fs);
    post = round(post * fs);%todo - uwaga zmaina 3-6
    gap = 0;

    start_idx = 1 + (i-1)*K;
    end_idx = start_idx + (K-1);
    printf('Fold number %d, start_idx = %d, end_idx = %d\n', i, start_idx, end_idx);

    train_range = [ 1:(start_idx-1) (end_idx+1):N ];
    test_range = start_idx:end_idx;

    train_indices = indexes(train_range,:)(:);
    test_indices = indexes(test_range,:)(:);
  
    train_trig = h.TRIG(train_indices);
    [train_feats,sz] = trigg(f,train_trig,pre,post,gap);
    train_feats = reshape(train_feats, sz);

    train_labels = h.Classlabel(train_indices);
%    train_labels = repmat(c_train,1,post-pre+1)'(:)';

    test_trig = h.TRIG(test_indices);
    [test_features,sz] = trigg(f,test_trig,pre,post,gap);
    test_features = reshape(test_features, sz);

    test_labels = h.Classlabel(test_indices);
%    test_labels = repmat(c_test,1,post-pre+1)'(:)';
end

