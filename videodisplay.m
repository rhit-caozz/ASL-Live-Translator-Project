%Video Display for Webcam 

% List available webcams
webcamlist;

% Initialize webcam
cam = webcam('Integrated Camera');

% Preview webcam feed
preview(cam);

% Display resolutions
disp(cam.AvailableResolutions);

% Set resolution
cam.Resolution = '320x240';

% Close preview window
closePreview(cam);

% Allocate an array to store imgs
numImages = 100;
img = zeros(240, 320, 3, numImages, 'uint8');  % Use a 4D array to store imgs


figure; 
for i = 1:numImages
    img(:,:,:,i) = snapshot(cam);  % Capture and store snapshot
    imshow(img(:,:,:,i));          % Display img
    pause(0.1);                    % Delay
end

% Clear webcam
clear('cam');