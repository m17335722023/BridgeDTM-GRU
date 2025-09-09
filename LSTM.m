        clear all;
        load('F:\兰新客专\数据\LSTMdata.mat'); 
%         load('F:\兰新客专\数据\随机后的data集.mat'); % 
%         for i=1:33167
%         if data{i,2}==1;
%             data{i,1}=data{i,1}*10;
%         end
%         end
% A=randperm(length(data))';
% data=data(A,:);
        dataSize = size(data, 1); % 数据大小
        features = cell(length(data),1);
        labels = zeros(dataSize, 1); % 标签

        for i = 1:dataSize
        %normalizedMatrix=mapminmax(data{i, 1});
        %features{i} = normalizedMatrix; % 将特征矩阵存储到features中
            %features{i} = data{i, 1}'; % data\mfcc
            features{i} = abs(data{i, 1}); % stft
            %features{i} = data{i, 1}; % 小波\fft
            labels(i) = data{i, 2}; % 将标签存储到labels中
        end

        labels=categorical(labels);
        
        XTrain=features(1:1600);
        XValidation=features(1601:2000,:);
        YTrain=labels(1:1600);
        YValidation=labels(1601:2000);
        Validation={XValidation,YValidation};
%         XTest=features(1601:1960,:);
%         YTest=labels(1601:1960);
%         XTrain=features(1:422);
%         XValidation=features(423:542);
%         YTrain=labels(1:422);
%         YValidation=labels(423:542);
%         Validation={XValidation,YValidation};
        
%         XTrain=features(1:26500);
%         XValidation=features(26501:33167);
%         YTrain=labels(1:26500);
%         YValidation=labels(26501:33167);
%         Validation={XValidation,YValidation};
miniBatchSize=50; %50
valFrequency = floor(length(XTrain)/miniBatchSize);
        %设置参数
        inputSize = size(XTrain{1,1},1);         %32个输入节点
        numHiddenUnits =64;   %128个隐藏节点
        numClasses = 2;        %2种分类结果
        DropoutLayer=0.5;
        
        layers = [ ...
            sequenceInputLayer(inputSize)                   %sequence输入
            %lstmLayer(numHiddenUnits,'OutputMode','sequence')   %lstm
            lstmLayer(numHiddenUnits,'OutputMode','last')   %lstm
            %dropoutLayer(DropoutLayer)
            fullyConnectedLayer(numClasses)                 %全连接
            softmaxLayer                                    %softmax
            classificationLayer];                           %label输出

       options = trainingOptions('adam', ...
            'ExecutionEnvironment','gpu', ...
            'InitialLearnRate',0.0001, ...   %data 0.0001   其余0.00001
            'MaxEpochs',50, ...
            'MiniBatchSize',miniBatchSize, ...
            'GradientThreshold',1, ...
            'ValidationData',Validation, ...
            'ValidationFrequency',valFrequency, ...
            'Shuffle','every-epoch', ...
            'Verbose',false, ...
            'Plots','training-progress');
        
        %[net,info]=trainNetwork(XTrain,YTrain,layers, options);    %训练
        
        %save(['F:\兰新客专\模型\LSTM\fft\'   '-Network_model_1_64.mat'],'net','info');

        load('F:\兰新客专\模型\LSTM\stft\-Network_model.mat'); 
        t=0;
        tic;
        YPredTrain = classify(net, XTrain); 
        t=t+toc;
        accuracyTrain = sum(YPredTrain == YTrain) / length(YTrain);        %计算准确度
%         YPredTest = classify(net, XTest);                      %测试
%         accuracyTest = sum(YPredTest == YTest) / length(YTest);        %计算准确度
          YPredValidation = classify(net, XValidation);                      %测试
          accuracyValidation = sum(YPredValidation == YValidation) / length(YValidation);        %计算准确度
        %save('F:\兰新客专\模型\LSTM\fft\result_1_64.mat','YPredTrain','YTrain','YPredValidation','YValidation','info'); 
%  figure %创建混淆矩阵图
%  cm = confusionchart(YPredValidation,YValidation);