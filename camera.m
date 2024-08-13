    %% Video Display for Webcam with Live Caption
    clc;
    % List available webcams
    webcamlist;
    % Initialize webcam
    cam = webcam('Integrated Camera');
    % Preview webcam feed
    %preview(cam);
    % Display resolutions
    %disp(cam.AvailableResolutions);
    % Set resolution
    cam.Resolution = '320x240';
    % Close preview window
    %closePreview(cam);
    % Allocate an array to store imgs
    numImages = 1000;
    img = zeros(240, 320, 3, numImages, 'uint8');  % Use a 4D array to store imgs
    figure;
    test = zeros([100, 1]);
    
    %% Net handle
    rootdir = 'archive\ASL_Alphabet_Dataset/asl_alphabet_train';
    %net = load("vgg16_net.mat");
    net = load("alex_net.mat");
    inputSize = net.net.Layers(1).InputSize;
    images = imageDatastore(...
       rootdir, ...
       'IncludeSubfolders',true, ...
       'LabelSource', 'foldernames');
    % Make datastores for the validation and testing sets similarly.
    fprintf('Read images into datastores\n');
    [trainImages, validateImages, testImages] = splitEachLabel(images, 0.6, 0.2,'randomized');
    classNames = categories(trainImages.Labels); %get labels
    numClasses = numel(classNames);
    
    
    
    %% Do live translation
    for i = 1:numImages
       cur_img = snapshot(cam);  % Capture and store snapshot
       
       img(:,:,:,i) = cur_img;
       RGB = insertText(img(:,:,:,i),[140 373; 130 200],test(i), FontSize =14,...
       BoxOpacity=0.4,TextColor="white", AnchorPoint = 'CenterBottom');
       
       cur_img = imresize(cur_img, [inputSize(1), inputSize(2)]);
         
       imshow(RGB);
       printScores = minibatchpredict(net.net, cur_img); %predict
       printPredictions = scores2label(printScores, classNames); %turn to a string
       prediction = string(printPredictions);
       if(prediction == "space")
           prediction = " ";
       end
       fprintf(prediction);
       pause(3);                    % Delay
    end
    % Clear webcam
    clear('cam');
    
     %% This handles saving if necessary (goes back into for loop)
       %subDir = 'cameraTranslate';
       %filename = fullfile(subDir, [num2str(i), '.png']);
       %imwrite(img(:, :, :, i), filename);