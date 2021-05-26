# Deep ConvNET Predicts Imagery Tasks Through EEG

## If you use these codes in your project please gently cite as follows:

@Article{Altan2021, <br>
author={Altan, Gokhan<br>
and Yay{\i}k, Apdullah<br>
and Kutlu, Yakup},<br>
title={Deep Learning with ConvNet Predicts Imagery Tasks Through EEG},<br>
journal={Neural Processing Letters},<br>
year={2021},<br>
month={May},<br>
day={25},<br>
issn={1573-773X},<br>
doi={10.1007/s11063-021-10533-7},<br>
url={https://doi.org/10.1007/s11063-021-10533-7}<br>
}

## Train Deep ConvNET with raw EEG data
	
### downloadEEGMMI
Downloads and saves EEGMMI dataset  from Pyhsionet with corresponding events event

		X .................vector includes subject ids to be downloaded (1-109)
		n..................tasks to be downloaded (1-14)

### usage
                   subject=1:15
		   task=[2,5,7]
                   downloadEEGMMI(subject, task)
### files
		 S001R08.mat.......data file id:1, task: 8
	         ann_S001R08.mat...event file id:1, task: 8

### isegment
### [data, label]=isegment(id)
	        Segments data for any subject
                id ..............subject number (choices: 1-62)
                data.............EEG data
                label............label related to data(with considering
                                 annotation)
                requires ann.mat file that includes annotations 
### usage
                [data2, label2]=isegment(2);


### tempimag
###  feature=tempimag(data, channelnumber)
	Constructs temporal images 

                data ..............EEG data (each row corresponds to a channel X trials)
                channelnumber......Number of channles 
                feature............Images related to each trial with
                                   struct  data type
###  usage
                data=randn(2880, 656);
                feature=tempimag(data, 64);
                figure, imshow(feature.images{1})

###  sendimage2folders
###  sendimage2folders(feature, label)
	Sends images to labeled folders

###  ReadyforClassifyConvNet
	Makes data ready for deep ConvNet

###  implementConvNET
	Scripts to train and test with deep ConvNet

## Multi-Layer Perceptron with Hand-Crafted Spectral Features

###  ReadyforClassifyMLP
	Makes data ready for MLP including Welch periodogram

###  implementMLP
	Scripts to train and test with MLP





