clear all
load('F:\兰新客专\数据\随机后的data集.mat');
newData=data;
for tt=1:length(newData)
    % 假设你的振动加速度信号为 acceleration，采样频率为 Fs
    acceleration=newData{tt,1}';
    Fs=50;
    % 假设你的振动加速度信号为 acceleration，采样频率为 Fs
    
    % Step 1: 进行时频分析
    windowLength =250; % 窗口长度
    overlap = round(windowLength/2); % 重叠长度
    nfft = 2^nextpow2(windowLength); % FFT长度
    
    [s, f, t] = spectrogram(acceleration, windowLength, overlap, nfft, Fs, 'yaxis');
    
    % s 是频谱矩阵，每列代表一个时间段的频谱
    % f 是频率向量
    % t 是时间向量
    
    % Step 2: 绘制时频谱图
    figure;
    imagesc(t, f, log10(abs(s))); % 使用对数尺度绘制幅度谱
    colorbar;
    xlabel('时间 (秒)');
    ylabel('频率 (Hz)');
    title('振动加速度信号的时频谱图');
    axis xy;   %y轴从下往上
    % Step 3: 提取时频域特征
    % 可根据需要选择特征提取方法，以下是一些常见的特征示例
    
    % a. 能量谱密度（Power Spectral Density）
    psd = abs(s).^2;
    
    % b. 峰值频率（Peak Frequency）
    [~, maxIndex] = max(psd);
    peakFreq = f(maxIndex);
    
    % c. 平均频率（Mean Frequency）
    meanFreq = sum(psd.*f)/sum(psd);
    
    % d. 峭度（Kurtosis）
    kurt = kurtosis(acceleration);
    
    % % 打印提取的特征值
    % disp(['峰值频率: ', num2str(peakFreq), ' Hz']);
    % disp(['平均频率: ', num2str(meanFreq), ' Hz']);
    % disp(['峭度: ', num2str(kurt)]);
    data{tt,1}=s;
end
%save('F:\兰新客专\数据\LSTMstft.mat','data');
%% 出图
clear all
load('F:\兰新客专\数据\随机后的data集.mat');
newData=data;
for tt=1:2000
    % 假设你的振动加速度信号为 acceleration，采样频率为 Fs
    acceleration=newData{tt,1}';
    Fs=50;
    % 假设你的振动加速度信号为 acceleration，采样频率为 Fs
    
    % Step 1: 进行时频分析
    windowLength =250; % 窗口长度
    overlap = round(windowLength/2); % 重叠长度
    nfft = 2^nextpow2(windowLength); % FFT长度
    
    [s, f, t] = spectrogram(acceleration, windowLength, overlap, nfft, Fs, 'yaxis');
    
    % s 是频谱矩阵，每列代表一个时间段的频谱
    % f 是频率向量
    % t 是时间向量
    if data{tt,2}==0
        % Step 2: 绘制时频谱图
        %imagesc(t, f, abs(s)); % 使用对数尺度绘制幅度谱
        imagesc(t, f, 20*log10(abs(s))); % 使用对数尺度绘制幅度谱
        colorbar;
        axis xy;   %y轴从下往上
        xlabel('时间 (秒)');
        ylabel('频率 (Hz)');
        title('列车振动响应的时频谱图');
       
        %     set(gcf,'Position',[0,0,143.36,143.36]);
        %     set(gca,'Position',[0,0,1,1]);		%去除白边
        %     axis off;  %关闭坐标
        %saveas(gcf,['F:\兰新客专\数据\stft图像集\0\image',num2str(tt),'.jpg']); %保存当前窗口的图像
    else
        imagesc(t, f, 20*log10(abs(s))); % 使用对数尺度绘制幅度谱
        colorbar;
        axis xy;   %y轴从下往上
        xlabel('时间 (秒)');
        ylabel('频率 (Hz)');
        title('地震响应的时频谱图');

        %     set(gcf,'Position',[0,0,143.36,143.36]);
        %     set(gca,'Position',[0,0,1,1]);		%去除白边
        %     axis off;  %关闭坐标
        %saveas(gcf,['F:\兰新客专\数据\stft图像集\1\image',num2str(tt),'.jpg']); %保存当前窗口的图像
    end
end
caxis([-6,10])
colormap(CustomColormap)
fontSize=20;
xlabel('\fontname{宋体}时间 \fontname{Times New Roman}(s)',fontsize=fontSize)
ylabel('\fontname{宋体}频率 \fontname{Times New Roman}(Hz)',fontsize=fontSize)
set(gca,'Fontsize',fontSize*.8,'Fontname','Times New Roman')
%save('F:\兰新客专\数据\LSTMstft.mat','data');