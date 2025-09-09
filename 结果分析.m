clear all
load('F:\兰新客专\模型\LSTM\data\result.mat');
YPredTrain_data=YPredTrain;YPredValidation_data=YPredValidation;
YTrain_data=YTrain;YValidation_data=YValidation;
accV_data = sum(YPredValidation == YValidation) / length(YValidation);
accT_data = sum(YPredTrain == YTrain) / length(YTrain);
load('F:\兰新客专\模型\LSTM\小波\result.mat');
YPredTrain_WT=YPredTrain;YPredValidation_WT=YPredValidation;
YTrain_WT=YTrain;YValidation_WT=YValidation;
accV_WT = sum(YPredValidation == YValidation) / length(YValidation);
accT_WT = sum(YPredTrain == YTrain) / length(YTrain);
load('F:\兰新客专\模型\LSTM\stft\result.mat');
YPredTrain_stft=YPredTrain;YPredValidation_stft=YPredValidation;
YTrain_stft=YTrain;YValidation_stft=YValidation;
accV_stft = sum(YPredValidation == YValidation) / length(YValidation);
accT_stft = sum(YPredTrain == YTrain) / length(YTrain);
load('F:\兰新客专\模型\LSTM\mfcc\result.mat');
YPredTrain_mfcc=YPredTrain;YPredValidation_mfcc=YPredValidation;
YTrain_mfcc=YTrain;YValidation_mfcc=YValidation;
accV_mfcc = sum(YPredValidation == YValidation) / length(YValidation);
accT_mfcc = sum(YPredTrain == YTrain) / length(YTrain);
load('F:\兰新客专\模型\resnet\小波\result.mat');
YPredTrain_WT2=YPredTrain;YPredValidation_WT2=YPredValidation;
YTrain_WT2=imdsTrain;YValidation_WT2=imdsValidation;
accV_WT2 = mean(YPredValidation == imdsValidation.Labels);
accT_WT2 = mean(YPredTrain == imdsTrain.Labels);
load('F:\兰新客专\模型\resnet\stft\result.mat');
YPredTrain_stft2=YPredTrain;YPredValidation_stft2=YPredValidation;
YTrain_stft2=imdsTrain;YValidation_stft2=imdsValidation;
accV_stft2 = mean(YPredValidation == imdsValidation.Labels);
accT_stft2 = mean(YPredTrain == imdsTrain.Labels);
load('F:\兰新客专\模型\resnet\mfcc\result.mat');
YPredTrain_mfcc2=YPredTrain;YPredValidation_mfcc2=YPredValidation;
YTrain_mfcc2=imdsTrain;YValidation_mfcc2=imdsValidation;
accV_mfcc2 = mean(YPredValidation == imdsValidation.Labels);
accT_mfcc2 = mean(YPredTrain == imdsTrain.Labels);

%% 混淆矩阵
figure %创建混淆矩阵图
cm = confusionchart(YValidation_mfcc,YPredValidation_mfcc);