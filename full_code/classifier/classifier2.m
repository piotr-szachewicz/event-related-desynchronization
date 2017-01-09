%run get_features.m

% CLASSIFICATION -- using Shogun!

%x,sz] = trigg(s,TRIG,pre,post,gap)

pre = round(3 * fs);
post = round(6 * fs);
gap = 0;
[x,sz] = trigg(f,h.TRIG,pre,post,gap);
%d = reshape(x,sz); % 80 x 751 x 288 - training features

c = h.Classlabel;
train_labels = repmat(c,1,post-pre+1)'(:)';

init_shogun

feats_train=RealFeatures(x);
width=2.1;
%kernel=GaussianKernel(feats_train, feats_train, width);

C=1.2;
epsilon=1e-5;
num_threads=8;
labels=MulticlassLabels(train_labels);

%svm=MulticlassLibSVM(C, kernel, labels);
%svm=GMNPSVM(C,kernel,labels);%dziala

svm=MulticlassLibLinear(1.2,feats_train,labels);
%svm = LDA(3,feats_train,labels);

%svm=MulticlassLibSVM(C, feats_train, labels);
%svm = LDA(3,feats_train, labels);
%svm.set_epsilon(epsilon);
svm.parallel.set_num_threads(num_threads);
svm.train();

clas_labels = classifier.apply().get_labels();

kappa(clas_labels,train_labels) 

% todo add some cross-validation
% change SVM to something faster - LDA?
% http://stats.stackexchange.com/questions/47849/svm-failing-entirely-with-when-test-set-is-varied
