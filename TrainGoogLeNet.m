clear
parentDir='';
dataDir='TrainSpecs';

allImages = imageDatastore({fullfile(parentDir,dataDir), fullfile(parentDir,'SVD')},...
    'IncludeSubfolders',true,...
    'LabelSource','foldernames');
rng default

[imgsTrain,imgsValidation] = splitEachLabel(allImages,0.8,'randomized');

disp(['Number of training images: ',num2str(numel(imgsTrain.Files))]);
disp(['Number of validation images: ',num2str(numel(imgsValidation.Files))]);

net = googlenet;

lgraph = layerGraph(net);

newDropoutLayer = dropoutLayer(0.6,'Name','new_Dropout');
lgraph = replaceLayer(lgraph,'pool5-drop_7x7_s1',newDropoutLayer);

numClasses = numel(categories(imgsTrain.Labels));
newConnectedLayer = fullyConnectedLayer(numClasses,'Name','new_fc',...
    'WeightLearnRateFactor',5,'BiasLearnRateFactor',5);
lgraph = replaceLayer(lgraph,'loss3-classifier',newConnectedLayer);

newClassLayer = classificationLayer('Name','new_classoutput');
lgraph = replaceLayer(lgraph,'output',newClassLayer);

options = trainingOptions('sgdm',...
    'MiniBatchSize',15,...
    'MaxEpochs',200,...
    'InitialLearnRate',1e-4,...
    'ValidationData',imgsValidation,...
    'ValidationFrequency',10,...
    'Verbose',1,...
    'ExecutionEnvironment','cpu',...
    'Plots','training-progress',...
    'OutputNetwork',"best-validation-loss",...
    'ValidationPatience', 25,...
    'LearnRateSchedule', 'piecewise',...
    'LearnRateDropPeriod', 25,...
    'LearnRateDropFactor', 0.1);
rng(3)

tic
[trainedGN, tr] = trainNetwork(imgsTrain,lgraph,options);
time = toc;

[YPred,probs] = classify(trainedGN,imgsValidation);
accuracy = mean(YPred==imgsValidation.Labels);
disp(['GoogLeNet Accuracy: ',num2str(100*accuracy),'%'])

% parentDir='';
% dataDir='TestSpecs';
% 
% imgsTest = imageDatastore(fullfile(parentDir,dataDir),...
%     'IncludeSubfolders',true,...
%     'LabelSource','foldernames');
% 
% [YPred,probs] = classify(trainedGN,imgsTest);
% accuracy = mean(YPred==imgsTest.Labels);
% 
% fileID = fopen('results.txt', 'a+');
% fprintf(fileID,'%d %f %f \n',size(tr.TrainingAccuracy,2), time, accuracy);
% fclose(fileID);