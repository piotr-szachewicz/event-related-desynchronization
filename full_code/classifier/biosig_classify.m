function [classifier_train_labels,classifier_test_labels] = biosig_classify(train_feat, test_feat, train_labels, test_labels)
    MODE.TYPE = 'LDA'; 

    trial_len = size(train_feat, 2);
    
    train_labels = repmat(train_labels,1, trial_len)'(:); % 8192 x 1
    test_labels = repmat(test_labels,1, trial_len)'(:); % 1024 x 1

    train_feat = reshape_features(train_feat);% 8192 x 80
    test_feat = reshape_features(test_feat); % 1024 x 80

    cc = train_sc(train_feat,train_labels,MODE);

    r = test_sc(cc,train_feat,MODE,train_labels);
    [a, classifier_train_labels] = max(r.output, [], 2); % 8192 x 1

    r = test_sc(cc,test_feat,MODE,test_labels);
    [b, classifier_test_labels] = max(r.output, [], 2); % 1024 x 1

    classifier_train_labels = reshape(classifier_train_labels, [trial_len, size(classifier_train_labels,1)/trial_len]); % 32 x 256
    classifier_test_labels = reshape(classifier_test_labels, [trial_len, size(classifier_test_labels,1)/trial_len]); % 32 x 32

end


