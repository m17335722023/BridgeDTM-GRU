clear all
load('F:\兰新客专\数据\随机后的data集.mat');

% 假设你的振动加速度信号为 acceleration，采样频率为 Fs
acceleration=data{1,1}';
Fs=50;
% 假设你的振动加速度信号为 acceleration，采样频率为 Fs

% Step 1: 经验模态分解（Empirical Mode Decomposition，EMD）
imf = emd(acceleration);

% Step 2: 提取时频域特征
numIMFs = size(imf, 2); % IMF的数量

featureMatrix = []; % 特征矩阵

for i = 1:numIMFs
    % 对每个IMF进行时频分析
    windowLength = 256; % 窗口长度
    overlap = round(windowLength/2); % 重叠长度
    nfft = 2^nextpow2(windowLength); % FFT长度

    [s, f, t] = spectrogram(imf(:,i), windowLength, overlap, nfft, Fs, 'yaxis');

    % 提取时频域特征
    % 可根据需要选择特征提取方法，以下是一些常见的特征示例

    % a. 能量谱密度（Power Spectral Density）
    psd = abs(s).^2;

    % b. 峰值频率（Peak Frequency）
    [~, maxIndex] = max(psd);
    peakFreq = f(maxIndex);

    % c. 平均频率（Mean Frequency）
    meanFreq = sum(psd.*f)/sum(psd);

    % d. 峭度（Kurtosis）
    kurt = kurtosis(imf(:,i));

    % 将特征存储到特征矩阵中
%     featureVector = [psd', peakFreq', meanFreq', kurt'];
%     featureMatrix = [featureMatrix; featureVector];
end

% 打印特征矩阵
disp('特征矩阵:');
disp(featureMatrix);
