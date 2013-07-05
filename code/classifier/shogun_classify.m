function [classifier_train_labels, classifier_test_labels] = shogun_classify(train_feat, test_feat, train_labels, test_labels, params)
    init_shogun
    % TODO TODO TODO -- uwaga, zeby uzyc czegos, to musi byc tu zadeklarowane!!
    global RealFeatures;
    global MulticlassLabels;
    global GaussianKernel;
    global LinearKernel;
    global MulticlassLibSVM;
    global QDA;
    global MulticlassLogisticRegression;
    global GMNPSVM;

    printf('WARNING !!!!! -- \n');
    size(train_labels)
    size(test_labels)
    size(train_feat)
    size(test_feat)

    step = 30; 
    train_labels = train_labels(:, 1:step:end);
    test_labels = test_labels(:, 1:step:end);
    train_feat = train_feat(:, 1:step:end, :);
    test_feat = test_feat(:, 1:step:end, :);

    printf('AFTER REDUCING !!!!! -- \n');
    size(train_labels)
    size(test_labels)
    size(train_feat)
    size(test_feat)

    trial_len = size(train_feat, 2);
    train_labels = repmat(train_labels,1, trial_len)'(:)' - 1; % 8192 x 1
    test_labels = repmat(test_labels,1, trial_len)'(:)' - 1; % 1024 x 1

    train_feat = reshape_features(train_feat)';% 8192 x 80
    test_feat = reshape_features(test_feat)'; % 1024 x 80

%    train_feat = train_feat(:, 1:150);
%    train_labels = train_labels(:, 1:150);

    s_train_feat = RealFeatures(train_feat);
    s_test_feat = RealFeatures(test_feat);

    if (strcmp(params.kernel, 'gaussian'))
    	width=params.kernel_width;
    	printf('Gaussian kernel, width = %f\n', width);
        kernel=GaussianKernel(s_train_feat, s_train_feat, width);
    else
	printf('Linear kernel\n');
        kernel=LinearKernel(s_train_feat, s_train_feat);
    end
    s_train_labels=MulticlassLabels(train_labels);

    C=params.C;
%    epsilon=1e-5;
    num_threads=8;

%    classifier=QDA(s_train_feat,s_train_labels);
    classifier=MulticlassLibSVM(C,kernel,s_train_labels);
%    classifier=GMNPSVM(C,kernel,s_train_labels);
%    classifier = MulticlassLogisticRegression(C, s_train_feat, s_train_labels);
    classifier.parallel.set_num_threads(num_threads);
    printf('TRAINING SVM.');
    classifier.train();

    printf('APPLYING SVM');
    classifier_train_labels = classifier.apply().get_labels() + 1;
    kernel.init(s_train_feat, s_test_feat);
    classifier_test_labels = classifier.apply().get_labels() + 1;
%    classifier_test_labels = classifier.apply(s_test_feat)+1;

    classifier_train_labels = reshape(classifier_train_labels, [trial_len, size(classifier_train_labels,2)/trial_len]); % 32 x 256
    classifier_test_labels = reshape(classifier_test_labels, [trial_len, size(classifier_test_labels,2)/trial_len]); % 32 x 32

%    classifier.get_bias();
%    classifier.get_w();
end


