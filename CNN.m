clear all
% 创建图像数据存储对象
imds = imageDatastore('F:\兰新客专\数据\fft图像集', 'IncludeSubfolders',true,'FileExtensions', '.jpg', 'LabelSource', 'foldernames'); 

% 划分训练集和验证集
[imdsTrain,imdsValidation] = splitEachLabel(imds,0.7);
% 设置输入图像的大小和通道数
inputSize = [224 224 3];

% 设置类别数
numClasses = 2;

% 创建 CNN 模型
layers = [
    imageInputLayer(inputSize)
    
    % 添加卷积层
    convolution2dLayer(3, 64, 'Padding', 'same')
    batchNormalizationLayer
    reluLayer
    
    % 添加池化层
    maxPooling2dLayer(2, 'Stride', 2)
    
    % 添加更多卷积层和池化层
    convolution2dLayer(3, 128, 'Padding', 'same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2, 'Stride', 2)
    
    % 添加全连接层
    fullyConnectedLayer(128)
    reluLayer
    
    % 添加输出层
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer
];

augimdsValidation = augmentedImageDatastore(inputSize(1:2),imdsValidation);

% 设置训练选项
options = trainingOptions('adam', ...
    'ExecutionEnvironment','gpu', ...
    'MiniBatchSize', 20, ...
    'MaxEpochs', 20, ...
    'Shuffle','once', ...
    'ValidationData',augimdsValidation, ...
    'ValidationFrequency',70, ...
    'InitialLearnRate', 0.00001, ...
    'Verbose', false, ...
    'Plots','training-progress');

% 设置训练选项
% options = trainingOptions('adam', ...
%     'ExecutionEnvironment','gpu', ...
%     'MiniBatchSize', 10, ...
%     'MaxEpochs', 20, ...
%     'Verbose', false, ...
%     'Plots','training-progress');

% 训练网络
[net,info] = trainNetwork(imdsTrain, layers, options);
save(['F:\兰新客专\模型\CNN\fft\'   '-Network_model.mat'],'net','info');
load('F:\兰新客专\模型\CNN\fft\-Network_model.mat'); 
t=0;
tic;
 [YPredValidation,probsValidation] = classify(net,imdsValidation);
 t=t+toc;
 accuracyValidation = mean(YPredValidation == imdsValidation.Labels);
 [YPredTrain,probsTrain] = classify(net,imdsTrain);
 accuracyTrain = mean(YPredTrain == imdsTrain.Labels);
%  [YPredTest,probsTest] = classify(net,augimdsTest);
%  accuracyTest = mean(YPredTest == imdsTest.Labels);
save('F:\兰新客专\模型\CNN\fft\result.mat','YPredValidation','imdsValidation','YPredTrain','imdsTrain','info'); 
% % 对验证集进行分类预测
% YPred = classify(net, imdsValidation);
% 
% % 计算分类准确率
% accuracy = sum(YPred == imdsValidation.Labels) / numel(imdsValidation.Labels);
% 
% % 显示准确率
% %disp(['分类准确率: ' num2str(accuracy)]);
