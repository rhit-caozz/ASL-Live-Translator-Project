# CSSE463_ASL
Image recognition project


## Packages
Computer Vision Toolbox v 24.1 <br>
Deep Learning Toolbox v 24.1 <br>
Deep Learning Toolbox Model for Alex Network v 24.1.0 <br>
Deep Learning Toolbox Model for VGG-16 Network v 24.1.0 (Optional for training a VGG-16 Network)<br>
Image Processing Toolbox v 24.1 <br>
Matlab Support Package for USB Webcams v 24.1.1 <br>
Statistics and Machine Learning Toolbox v 24.1 <br>
Parallel Computing Toolbox v 24.1 (Optional for training using the parallel-gpu or auto options)<br>

## Data
ASL(American Sign Language) Alphabet Dataset<br>
Kaggle Link: https://www.kaggle.com/datasets/debashishsau/aslamerican-sign-language-aplhabet-dataset/data

### Installation
<ol>
  <li>Extract the Dataset</li>
  <li>Put the ASL_Alphabet_Dataset folder in the same directory as all of the matlab files</li>
</ol>

## Training a Network

When creating a network for our dataset only two steps are needed. 

<ol>
  <li>Run the splitData.m script to get mat files for the val, train, and test data used for training</li>
  <li>Run either the alexnet_net.m or vgg16_net.m scripts to create a network trained on the split datasets</li>
</ol>

## Testing the Networks Performance

To test how the network performs on the test set use the networkTable.m script to create a table of information regarding how the networks performs on your test set

## Running Live Translator

<ol>
  <li>Download Kaggle ASL Dataset and alex_net trained classifier into the same directory as camera.m </li>
  <li>Unzip Kaggle dataset and have the top level directory - default name 'archive' - into the same directory as camera.m </li>
  <li>camera.m uses base integrated camera. This can modified within the script. Ensure that the proper camera is being used </li>
  <li>Run camera.m to begin live translations</li>
</ol>

## Notes
<ol>
  <li>extractfeatures.m and appendletters.m are experimental code files and are not contributory to training a network or running the translator</li>
</ol>
