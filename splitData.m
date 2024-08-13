clc;

rootdir = 'ASL_Alphabet_Dataset\asl_alphabet_train';

fprintf('Read images into datastores\n');
images = imageDatastore(...
    rootdir, ...
    'IncludeSubfolders',true, ...
    'LabelSource', 'foldernames');

%Make datastores for the test, validation, and testing sets similarly.
%% Run once to get data split 
[train, val, test] = splitEachLabel(images, 0.6, 0.2,'randomized');

%Create a singular dataset for deterministic results
save("train.mat", "train");
save("val.mat", "val");
save("test.mat", "test");
save("images.mat", "images");
fprintf('Created random split datasets\n');