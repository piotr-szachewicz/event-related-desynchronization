%run get_features.m

more off;
% get indexes for each class
indexes = []
for i = 1:4,
    v = find(h.Classlabel==i);
    v = v(randperm(size(v,1)));
    indexes = [ indexes v ];
end

K = 8;
N = size(v,1);

train_kappas = [];
test_kappas = [];

classifier_output = [];
true_output = [];

pre = params.trim_low;
post = params.trim_high;
printf('Data trimmed for learning from %f to %f\n', pre, post);

for i = 1:(N/K),
    [train_feat, test_feat, train_labels, test_labels] = get_data(i, indexes, h, f, K, N, pre, post);

    if(strcmp(tolower(params.classifier.type), 'lda'))
        printf('Running LDA Classifier\n');
        [classifier_train_labels, classifier_test_labels] = biosig_classify(train_feat, test_feat, train_labels, test_labels);
    else
        printf('Running Shogun Classifier\n');
        [classifier_train_labels, classifier_test_labels] = shogun_classify(train_feat, test_feat, train_labels, test_labels, params.classifier);
    end

    if(fieldexists(params, 'postprocessing') && params.postprocessing > 1)
        classifier_train_labels = postprocessing(classifier_train_labels, params.postprocessing);
        classifier_test_labels = postprocessing(classifier_test_labels, params.postprocessing);
    end

    [train_kappa, test_kappa] = evaluate_classifier(classifier_train_labels, classifier_test_labels, train_labels, test_labels);

    classifier_output = [ classifier_output classifier_test_labels];
    true_output = [ true_output test_labels ];

    train_kappas = [ train_kappas train_kappa ];
    test_kappas = [ test_kappas test_kappa ];
end

disp('-------------------------')
disp('train kappas: ')
disp(train_kappas)
printf('Mean train kappa -- %f\n', mean(train_kappas));
disp('test kappas: ')
disp(test_kappas);
printf('Mean test kappa --- %f\n', mean(test_kappas));

disp('----------------------------------')

[real_kappa, index, all_kappas] = get_kappa(classifier_output, true_output);
printf('REAL KAPPA OUTPUT -- %f\n', real_kappa);
max_time = pre + index / h.SampleRate;
printf('Max time = %f\n', max_time);

printf('Feature set size: %d x %d\n', size(f,1), size(f,2));

printf('\n\n\n\n');
