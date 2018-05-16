clearvars
% digitDatasetPath = fullfile(matlabroot,'toolbox','nnet','nndemos', ...
%     'nndatasets','DigitDataset');
subject2path='/media/abd/Yeni Birim/Motor Imagery ConvNET/all_subjects';
imds = imageDatastore(subject2path, ...
    'IncludeSubfolders',true,'LabelSource','foldernames');

% figure;
% perm = randperm(45,20);
% for i = 1:20
%     subplot(4,5,i);
%     imshow(imds.Files{perm(i)});
% end

labelCount1 = countEachLabel(imds)

% img = readimage(imds,1);
% size(img)

numTrainFiles1 = 1200;
[imdsTrain1,imdsValidation] = splitEachLabel(imds,numTrainFiles1,'randomize');

labelCount2 = countEachLabel(imdsTrain1)

numTrainFiles2=900;
[imdsTrain2,imdsTest] = splitEachLabel(imdsTrain1,numTrainFiles2,'randomize');

labelCount3 = countEachLabel(imdsTrain2)

layers = [
    imageInputLayer([64 656 1])
    
    convolution2dLayer([64, 2],6) % 1, 328, 6 % spatial conv
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer([1, 2],'Stride',[2, 1]) % 1, 164, 6
    
    convolution2dLayer([1, 11], 12) % 1, 154, 12 % temporal conv
    batchNormalizationLayer
    reluLayer    
    maxPooling2dLayer([1,2],'Stride',[2,1]) % 1, 77, 12
%     
    convolution2dLayer([1, 10], 24) % 1, 68, 24 
    batchNormalizationLayer
    reluLayer    
    maxPooling2dLayer([1,2],'Stride',[2,1]) % 1, 34, 24
    dropoutLayer
    fullyConnectedLayer(15)
    reluLayer
    fullyConnectedLayer(2)
    softmaxLayer
    classificationLayer];

options = trainingOptions('sgdm', ...
    'Momentum',0.9,...
    'InitialLearnRate', 0.001, ...
    'LearnRateSchedule', 'piecewise', ...  
    'LearnRateDropFactor', 0.1, ... 
    'LearnRateDropPeriod', 10, ...
    'MiniBatchSize', 100, ...
    'MaxEpochs', 20 , ...
    'Verbose', false, ...
    'VerboseFrequency', 10 , ...   
    'ValidationData', imdsValidation, ...
    'ValidationFrequency',10, ...
    'ValidationPatience', 15, ...
    'Shuffle', 'once', ...
    'ExecutionEnvironment', 'auto', ...
    'Plots','training-progress', ...
    'SequenceLength', 'longest');
% 
% 'Epsilon',  1.0000e-08, ...,
%     'SquaredGradientDecayFactor',0.99, ...
net = trainNetwork(imdsTrain2,layers,options);

YPred_val = classify(net,imdsValidation);
YValidation = imdsValidation.Labels;

accuracy_Val = sum(YPred_val == YValidation)/numel(YValidation)


YPred_test = classify(net,imdsTest);
YTest = imdsTest.Labels;

accuracy_Test = sum(YPred_test == YTest)/numel(YTest)

 CMstoc=crosstab(YPred_test, YTest), save CMstoc CMstoc
















