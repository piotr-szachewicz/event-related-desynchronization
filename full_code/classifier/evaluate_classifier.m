function [train_kappa, test_kappa] = evaluate_classifier(classifier_train_labels, classifier_test_labels, train_labels, test_labels)
    train_kappa = get_kappa(classifier_train_labels, train_labels);
    test_kappa = get_kappa(classifier_test_labels, test_labels);

    printf('Kappa for training set = %f\n', train_kappa);
    printf('Kappa for testing set = %f\n', test_kappa);
end

