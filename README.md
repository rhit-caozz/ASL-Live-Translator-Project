# CSSE463_ASL
Image recognition project


## Packages
Computer Vision Toolbox v 24.1 <br>
Deep Learning Toolbox v 24.1 <br>
Deep Learning Toolbox Model for Alex Network v 24.1.0 <br>
Image Processing Toolbox v 24.1 <br>
Matlab Support Package for USB Webcams v 24.1.1 <br>
Statistics and Machine Learning Toolbox v 24.1 <br>

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
  <li>Run the splitData.m script to get mat files for the val, train, and test data used for training and validation</li>
  <li>Run either the alexnet_net.m or vgg16_net.m scripts to create a network trained on the split datasets</li>
</ol>

## Testing the Networks Performance

To test how the network performs on the test set use the networkTable.m script to create a table of information regarding how the networks performs on your test set
