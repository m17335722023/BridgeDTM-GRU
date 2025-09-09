clear all
imds = imageDatastore('F:\兰新客专\数据\mfcc图像集', 'IncludeSubfolders',true,'FileExtensions', '.jpg', 'LabelSource', 'foldernames'); 
%[imdsTrain,imdsValidation,imdsTest] = splitEachLabel(imds,0.6,0.2,0.2);
%[imdsTrain,imdsTest] = splitEachLabel(imds,0.7);
[imdsTrain,imdsValidation] = splitEachLabel(imds,0.7);
%net = googlenet;   

%先help findLayersToReplace

net = resnet50;     
%analyzeNetwork(net);
net.Layers(1);
inputSize = net.Layers(1).InputSize;
lgraph = layerGraph(net);

[learnableLayer,classLayer] = findLayersToReplace(lgraph);
[learnableLayer,classLayer];

numClasses = numel(categories(imdsTrain.Labels));

if isa(learnableLayer,'nnet.cnn.layer.FullyConnectedLayer')
    newLearnableLayer = fullyConnectedLayer(numClasses, ...
        'Name','new_fc', ...
        'WeightLearnRateFactor',10, ...
        'BiasLearnRateFactor',10);
    
elseif isa(learnableLayer,'nnet.cnn.layer.Convolution2DLayer')
    newLearnableLayer = convolution2dLayer(1,numClasses, ...
        'Name','new_conv', ...
        'WeightLearnRateFactor',10, ...
        'BiasLearnRateFactor',10);
end

lgraph = replaceLayer(lgraph,learnableLayer.Name,newLearnableLayer);

newClassLayer = classificationLayer('Name','new_classoutput');
lgraph = replaceLayer(lgraph,classLayer.Name,newClassLayer);

% figure('Units','normalized','Position',[0.3 0.3 0.4 0.4]);
% plot(lgraph)
% ylim([0,10])

layers = lgraph.Layers;
connections = lgraph.Connections;

layers(1:10) = freezeWeights(layers(1:10));
lgraph = createLgraphUsingConnections(layers,connections);

pixelRange = [-30 30];
scaleRange = [0.9 1.1];
imageAugmenter = imageDataAugmenter( ...
    'RandXReflection',true, ...
    'RandXTranslation',pixelRange, ...
    'RandYTranslation',pixelRange, ...
    'RandXScale',scaleRange, ...
    'RandYScale',scaleRange);
augimdsTrain = augmentedImageDatastore(inputSize(1:2),imdsTrain, ...
    'DataAugmentation',imageAugmenter);

augimdsValidation = augmentedImageDatastore(inputSize(1:2),imdsValidation);
%augimdsTest = augmentedImageDatastore(inputSize(1:2),imdsTest);

miniBatchSize = 50;
valFrequency = floor(numel(augimdsTrain.Files)/miniBatchSize);
options = trainingOptions('sgdm', ...
    'MiniBatchSize',miniBatchSize, ...
    'MaxEpochs',20, ...
    'InitialLearnRate',0.00001, ...    %0.00001
    'Shuffle','once', ...
    'ValidationData',augimdsValidation, ...
    'ValidationFrequency',valFrequency, ...
    'Verbose',false, ...
    'Plots','training-progress');

%[net,info]= trainNetwork(augimdsTrain,lgraph,options);

%save(['F:\兰新客专\模型\resnet\fft\'   '-Network_model.mat'],'net','info');
load('F:\兰新客专\模型\resnet\mfcc\-Network_model.mat'); 
t=0;
tic;
 [YPredValidation,probsValidation] = classify(net,augimdsValidation);
 t=t+toc;
 accuracyValidation = mean(YPredValidation == imdsValidation.Labels);
 [YPredTrain,probsTrain] = classify(net,augimdsTrain);
 accuracyTrain = mean(YPredTrain == imdsTrain.Labels);
%  [YPredTest,probsTest] = classify(net,augimdsTest);
%  accuracyTest = mean(YPredTest == imdsTest.Labels);
%save('F:\兰新客专\模型\resnet\fft\result.mat','YPredValidation','imdsValidation','YPredTrain','imdsTrain','info'); 

% idx = randperm(numel(imdsValidation.Files),2);
% figure
% for i = 1:2
%     subplot(1,2,i)
%     I = readimage(imdsValidation,idx(i));
%     imshow(I)
%     label = YPred(idx(i));
%     title(string(label) + ", " + num2str(100*max(probs(idx(i),:)),3) + "%");
% end