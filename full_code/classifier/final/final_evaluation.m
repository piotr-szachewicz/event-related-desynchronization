function final_evaluation(params)

printf('Running final classifier evaluation experiment\n');
train_kap = [];
test_kap = [];
for i = 1:9,
    train_file = sprintf('A0%dT_red_bp.gdf', i);
    [f,h, xx, csp_matrix] = get_features(train_file, params);

    pre = ceil(params.trim_low * h.SampleRate);
    post = ceil(params.trim_high * h.SampleRate);
	gap = 0;

    [train_feats,sz] = trigg(f,h.TRIG,pre,post,gap);
    train_feats = reshape(train_feats, sz);
    train_labels = h.Classlabel;

	%% TEST DATA
    test_file = sprintf('A0%dE_red_bp.gdf', i);
    true_labels_file = strcat(get_data_directory(), sprintf('true_labels/A0%dE.mat', i));
    c = load(true_labels_file);
    test_labels = c.classlabel;

    params.csp_matrix = csp_matrix
    [f,h, xx, yy] = get_features(test_file, params, test_labels);

    [test_feats,sz] = trigg(f,h.TRIG,pre,post,gap);

    printf('AAAAAAAAAAAAAAAAAAAAAAAAAAA')
    size(test_feats)
    test_feats = reshape(test_feats, sz);

    % remove the data with artifacts.
    size(test_feats)
    test_feats = test_feats(:,:,h.ArtifactSelection==0);
    test_labels = test_labels(h.ArtifactSelection==0);
    size(test_feats)
    size(test_labels) 
%     h.ArtifactSelection

	% TEST CLASSIFIER
    if params.classifier.type == 'svm'
        printf('Running SVM Classifier\n');
        [classifier_train_labels, classifier_test_labels] = shogun_classify(train_feats, test_feats, train_labels, test_labels, params.classifier);
    else
        printf('Running LDA Classifier\n');
        [classifier_train_labels, classifier_test_labels] = biosig_classify(train_feats, test_feats, train_labels, test_labels);
    end

	% EVALUATE
    [train_kappa, test_kappa] = evaluate_classifier(classifier_train_labels, classifier_test_labels, train_labels, test_labels);

	train_kap = [train_kap train_kappa]
	test_kap =[ test_kap test_kappa]
end

printf('Testing finished. Results: \n');
mean(train_kap)
mean(test_kap)
params
end
