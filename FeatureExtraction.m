clc;
rootdir = "C:\Users\caozz\Documents\MATLAB\ASLdetector\archive";
images = imageDatastore(...
    rootdir, ...
    'IncludeSubfolders', true, ...
    'LabelSource', 'foldernames');
[trainImages, validateImages, testImages] = splitEachLabel(images, 0.6, 0.2,'randomized');
classNames = categories(trainImages.Labels);
numClasses = numel(classNames);

%% Set Up AlexNet
net = alexnet;
inputSize = net.Layers(1).InputSize;
augimdsTrain = augmentedImageDatastore(inputSize(1:2), trainImages);
augimdsValidate = augmentedImageDatastore(inputSize(1:2), validateImages);
augimdsTest = augmentedImageDatastore(inputSize(1:2), testImages);

%% Get Features from Net
layer = 'pool5';
featuresTrain = activations(net, augimdsTrain, layer, 'OutputAs', 'rows');
featuresValidate = activations(net, augimdsValidate, layer, 'OutputAs', 'rows'); 
featuresTest = activations(net, augimdsTest, layer, 'OutputAs', 'rows');
YTrain = trainImages.Labels;
YValidate = validateImages.Labels;
YTest = testImages.Labels;
%% Input Features into SVM
svmModel = fitcecoc(featuresTrain, YTrain, 'Learners', templateSVM('Standardize', true, 'KernelFunction', 'rbf', 'KernelScale', 10, 'BoxConstraint', 10));
[detectedClasses, scores] = predict(svmModel, featuresValidate);
acc = mean(detectedClasses == YValidate);
supp_vect = sum(svmModel.IsSupportVector)/size(featuresValidate, 1);
