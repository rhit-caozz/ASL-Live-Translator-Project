clc;
rootdir = 'C:\Users\caozz\Documents\MATLAB\ASLdetector\archive\ASL_Alphabet_Dataset/asl_alphabet_train';
net = load("vgg16_net.mat");
%load("alexnet.mat");
inputSize = net.net.Layers(1).InputSize;

images = imageDatastore(...
   rootdir, ...
   'IncludeSubfolders',true, ...
   'LabelSource', 'foldernames');
% Make datastores for the validation and testing sets similarly.
fprintf('Read images into datastores\n');
[trainImages, validateImages, testImages] = splitEachLabel(images, 0.6, 0.2,'randomized');
classNames = categories(trainImages.Labels);
numClasses = numel(classNames);

printImagesDir = 'C:\Users\caozz\Documents\MATLAB\ASLdetector\printImages';
printImages = imageDatastore(printImagesDir);
augimdsPrint = augmentedImageDatastore(inputSize(1:2), printImages);

%featureDim = 2;

printScores = minibatchpredict(net.net, augimdsPrint);
printPredictions = scores2label(printScores,classNames);

fprintf('Predicted labels for images in printImages folder:\n');
temp = "";
for i = 1:numel(printPredictions)
    prediction = string(printPredictions(i));
    if(prediction == "space")
        prediction = " ";
    end
    temp = temp + prediction;
end
disp(temp);
%images = imageDatastore(...
%   rootdir, ...
%   'IncludeSubfolders',true, ...
%   'LabelSource', 'foldernames');
% Make datastores for the validation and testing sets similarly.
%fprintf('Read images into datastores\n');
%[trainImages, validateImages, testImages] = splitEachLabel(images, 0.6, 0.2,'randomized');
%classNames = categories(trainImages.Labels);
%numClasses = numel(classNames);

%augimdsTrain = augmentedImageDatastore(inputSize(1:2), trainImages);
%augimdsValidate = augmentedImageDatastore(inputSize(1:2), validateImages);
%augimdsTest = augmentedImageDatastore(inputSize(1:2), testImages);

%scores = minibatchpredict(net.net, augimdsValidate);
%YPred = scores2label(scores, classNames);
%YValidation = validateImages.Labels;
%accuracy = mean(YPred == YValidation);