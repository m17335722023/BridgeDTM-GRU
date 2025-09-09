clear all;
load('F:\兰新客专\数据\LSTMdata2.mat'); % 
Hz=50;
%A=data{144,1};
%A=data{257,1};
%A=data{351,1};
% A=data{144,1};
% B=data{6,1};
A=data{417,1};
% B=data{409,1};
%B=data{7,1};
B=data{8,1}/10*2;
C(1,1:1466)=B(1,35:1500);
C(1,1467:1500)=B(1,1:34);
B=C;
t = (1:1500)/Hz; % 时间轴
figure;
set(gcf, 'Position', [50 200 1400 400]); 
set(gca,'LooseInset',get(gca,'TightInset'))
%subplot(2,1,1);
plot(t, A);
hold on;
plot(t, B);
ylim([-35, 35]);
set(gca,'color','w');
set(gca,'FontSize',25)  %是设置刻度字体大小
%title('地震振动');
ylabel('加速度（cm/s²）','fontsize',25)
xlabel('时间（s）','fontsize',25)
legend('地震响应','车致振动响应','fontsize',20)
% subplot(2,1,2);
% plot(t, B);
% ylim([-35, 35]);
% set(gca,'color','w');
% set(gca,'FontSize',25)  %是设置刻度字体大小
% title('列车振动');
% ylabel('加速度（cm/s²）','fontsize',25)
% xlabel('时间（s）','fontsize',25)
%% mfcc
figure;
subplot(2,2,2);
imagesc(mfccAA);
axis xy;   %y轴从下往上
colorbar;
set(gca,'FontSize',15)  %是设置刻度字体大小
title('地震振动mfcc特征矩阵');
xlabel('振动分帧帧数','fontsize',15);
ylabel('mfcc参数维数','fontsize',15);
subplot(2,2,4);
imagesc(mfccBB);
axis xy;   %y轴从下往上
colorbar;
set(gca,'FontSize',15)  %是设置刻度字体大小
title('列车振动mfcc特征矩阵');
xlabel('振动分帧帧数','fontsize',15);
ylabel('mfcc参数维数','fontsize',15);
subplot(2,2,1);
imagesc(EAA);
axis xy;   %y轴从下往上
colorbar;
set(gca,'FontSize',15)  %是设置刻度字体大小
title('地震振动谱线能量');
xlabel('振动分帧帧数','fontsize',15);
ylabel('mfcc参数维数','fontsize',15);
subplot(2,2,3);
imagesc(EBB);
axis xy;   %y轴从下往上
colorbar;
set(gca,'FontSize',15)  %是设置刻度字体大小
title('列车振动谱线能量');
xlabel('振动分帧帧数','fontsize',15);
ylabel('mfcc参数维数','fontsize',15);

%% 连续小波
clear all
load('F:\兰新客专\数据\LSTMdata2.mat'); % 
cell_array(:,1)=data(:,1);
%cell_array(:,1)=newData(:,1);
FREQ=centfrq('morl');
fs=50;

%for i = 1:numel(cell_array)
    i=8;
    vibration_data = cell_array{i, 1};
    
    t =5:5:30;
    hz=[15:-0.1:0.1];
    scales =FREQ*fs./hz;      
    %scales=1:1:100;
    coefs=cwt(vibration_data,scales,'morl');
    F=scal2frq(scales,'morl',0.02);
    figure(1);
    set(gca,'color','w');
    imagesc(t,F,abs(coefs));
    set(gca, 'YDir', 'normal');
    colormap(jet);
    colorbar;
    set(gca,'FontSize',15)  %是设置刻度字体大小
    xlabel('时间','fontsize',15);
    ylabel('频率（Hz）','fontsize',15);
    title('列车响应连续小波变换时频图');
data{i,1}=coefs;

 i=417;
    vibration_data = cell_array{i, 1};
    
    t =5:5:30;
    hz=[15:-0.1:0.1];
    scales =FREQ*fs./hz;      
    %scales=1:1:100;
    coefs=cwt(vibration_data,scales,'morl');
    F=scal2frq(scales,'morl',0.02);
    figure(2);
    set(gca,'color','w');
    imagesc(t,F,abs(coefs));
    set(gca, 'YDir', 'normal');
    colormap(jet);
    colorbar;
    set(gca,'FontSize',15)  %是设置刻度字体大小
    xlabel('时间','fontsize',15);
    ylabel('频率（Hz）','fontsize',15);
    title('地震响应连续小波变换时频图');
data{i,1}=coefs;
%% 短时傅里叶变换
clear all
load('F:\兰新客专\数据\LSTMdata2.mat'); % 
newData=data;

tt=8;
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
    figure(1);
    set(gca,'color','w');
imagesc(t, f, log10(abs(s))); % 使用对数尺度绘制幅度谱
colorbar;
xlabel('时间 (秒)','FontSize',15);
ylabel('频率 (Hz)','FontSize',15);
title('列车响应短时傅里叶变换时频对数图');
set(gca,'FontSize',15)  %是设置刻度字体大小
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


tt=417;
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
    figure(2);
    set(gca,'color','w');
imagesc(t, f, log10(abs(s))); % 使用对数尺度绘制幅度谱
colorbar;
xlabel('时间 (秒)','FontSize',15);
ylabel('频率 (Hz)','FontSize',15);
title('地震响应短时傅里叶变换时频对数图');
    set(gca,'FontSize',15)  %是设置刻度字体大小
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
%% mfcc
clear all
load('F:\兰新客专\数据\LSTMdata2.mat'); % 
newData=data;
lieche = cell(length(newData),2);

    tt=8;
    x=newData{tt,1};
    frameSize=100;  %帧长
    N = frameSize;
    inc=50;  %帧移
    p = 30;  %梅尔滤波器个数
    fs=50;
    % 本文语音信号的fs为16000Hz
    N2=length(x);  %语音信号长度

    %预加重
    for i=2:N2
        y(i)=x(i)-0.97*x(i-1);
    end
    y=y';%对y取转置
    S=enframe(y,frameSize,inc);%分帧,对语音信号x进行分帧，
    [a,b]=size(S);  %a为矩阵行数，b为矩阵列数
    %创建汉明窗矩阵C
    C=zeros(a,b);
    ham=hamming(b);
    for i=1:a
        C(i,:)=ham;
    end
    %将汉明窗C和S相乘得SC
    SC=S.*C;
    F=0;N=frameSize;
    for i=1:a
        %对SC作N=1024的FFT变换
        D(i,:)=fft(SC(i,:),N);
        %以下循环实现求取谱线能量
        for j=1:N
            t=abs(D(i,j));
            E(i,j)=(t^2);
        end
    end

    fl=0;fh=fs/2;%定义频率范围，低频和高频
    bl=2595*log10(1+fl/700);%得到梅尔刻度的最小值
    bh=2595*log10(1+fh/700);%得到梅尔刻度的最大值
    %梅尔坐标范围
    % p=26;%滤波器个数
    B=bh-bl;%梅尔刻度长度
    mm=linspace(0,B,p+2);%规划34个不同的梅尔刻度。但只有32个梅尔滤波器
    fm=700*(10.^(mm/2595)-1);%将Mel频率转换为频率
    W2=N/2+1;%fs/2内对应的FFT点数,1024个频率分量

    k=((N+1)*fm)/fs;%计算34个不同的k值
    hm=zeros(p,N);%创建hm矩阵
    df=fs/N;
    freq=(0:N-1)*df;%采样频率值

    %绘制梅尔滤波器
    for i=2:p+1
        %取整
        n0=floor(k(i-1));  %floor为向下取整，如果取整，表示三角滤波器组的各中心点被置于FFT 数据对应的的点位频率上，所以频率曲线的三角形顶点正好在FFT 数据点上，即美尔滤波器所有顶点在同一高度。
        n1=floor(k(i));
        n2=floor(k(i+1));
    %     n0=k(i-1);  %不取整代表直接按精确指定的中心频率点来计算的，这时滤波器中心频率就不一定在FFT 数据点对应位置，按FFT 点位所得曲线在低频段就不是完美的三角形，即美尔滤波器所有顶点不在同一高度。
    %     n1=k(i);
    %     n2=k(i+1);
        %要知道k(i)分别代表的是每个梅尔值在新的范围内的映射，其取值范围为：0-N/2
        %以下实现求取三角滤波器的频率响应。

        for j=1:N
           if n0<=j & j<=n1
               hm(i-1,j)=(j-n0)/(n1-n0);
           elseif n1<=j & j<=n2
               hm(i-1,j)=(n2-j)/(n2-n1);
           end
       end
       %此处求取H1(k)结束。
    end

     %梅尔滤波器滤波
     H=E*hm';
     %对H作自然对数运算
     %因为人耳听到的声音与信号本身的大小是幂次方关系，所以要求个对数
     for i=1:a
         for j=1:p
             H(i,j)=log(H(i,j));
         end
     end
     %作离散余弦变换 
    Fbank = H';
    Fbank1 = dct(Fbank);
    mfcc = Fbank1';
%     mfcc参数图
     figure(1);
     set(gca,'color','w');
     imagesc(log10(abs(mfcc')));
     axis xy;   %y轴从下往上
     colorbar;
     ylabel('梅尔滤波器组','FontSize',15);
     xlabel('时间 (秒)','FontSize',15);
     title('列车响应梅尔倒谱系数对数图');
set(gca,'FontSize',15)  %是设置刻度字体大小

    tt=417;
    x=newData{tt,1};
    frameSize=100;  %帧长
    N = frameSize;
    inc=50;  %帧移
    p = 30;  %梅尔滤波器个数
    fs=50;
    % 本文语音信号的fs为16000Hz
    N2=length(x);  %语音信号长度

    %预加重
    for i=2:N2
        y(i)=x(i)-0.97*x(i-1);
    end
    y=y';%对y取转置
    S=enframe(y,frameSize,inc);%分帧,对语音信号x进行分帧，
    [a,b]=size(S);  %a为矩阵行数，b为矩阵列数
    %创建汉明窗矩阵C
    C=zeros(a,b);
    ham=hamming(b);
    for i=1:a
        C(i,:)=ham;
    end
    %将汉明窗C和S相乘得SC
    SC=S.*C;
    F=0;N=frameSize;
    for i=1:a
        %对SC作N=1024的FFT变换
        D(i,:)=fft(SC(i,:),N);
        %以下循环实现求取谱线能量
        for j=1:N
            t=abs(D(i,j));
            E(i,j)=(t^2);
        end
    end

    fl=0;fh=fs/2;%定义频率范围，低频和高频
    bl=2595*log10(1+fl/700);%得到梅尔刻度的最小值
    bh=2595*log10(1+fh/700);%得到梅尔刻度的最大值
    %梅尔坐标范围
    % p=26;%滤波器个数
    B=bh-bl;%梅尔刻度长度
    mm=linspace(0,B,p+2);%规划34个不同的梅尔刻度。但只有32个梅尔滤波器
    fm=700*(10.^(mm/2595)-1);%将Mel频率转换为频率
    W2=N/2+1;%fs/2内对应的FFT点数,1024个频率分量

    k=((N+1)*fm)/fs;%计算34个不同的k值
    hm=zeros(p,N);%创建hm矩阵
    df=fs/N;
    freq=(0:N-1)*df;%采样频率值

    %绘制梅尔滤波器
    for i=2:p+1
        %取整
        n0=floor(k(i-1));  %floor为向下取整，如果取整，表示三角滤波器组的各中心点被置于FFT 数据对应的的点位频率上，所以频率曲线的三角形顶点正好在FFT 数据点上，即美尔滤波器所有顶点在同一高度。
        n1=floor(k(i));
        n2=floor(k(i+1));
    %     n0=k(i-1);  %不取整代表直接按精确指定的中心频率点来计算的，这时滤波器中心频率就不一定在FFT 数据点对应位置，按FFT 点位所得曲线在低频段就不是完美的三角形，即美尔滤波器所有顶点不在同一高度。
    %     n1=k(i);
    %     n2=k(i+1);
        %要知道k(i)分别代表的是每个梅尔值在新的范围内的映射，其取值范围为：0-N/2
        %以下实现求取三角滤波器的频率响应。

        for j=1:N
           if n0<=j & j<=n1
               hm(i-1,j)=(j-n0)/(n1-n0);
           elseif n1<=j & j<=n2
               hm(i-1,j)=(n2-j)/(n2-n1);
           end
       end
       %此处求取H1(k)结束。
    end

     %梅尔滤波器滤波
     H=E*hm';
     %对H作自然对数运算
     %因为人耳听到的声音与信号本身的大小是幂次方关系，所以要求个对数
     for i=1:a
         for j=1:p
             H(i,j)=log(H(i,j));
         end
     end
     %作离散余弦变换 
    Fbank = H';
    Fbank1 = dct(Fbank);
    mfcc = Fbank1';
%     mfcc参数图
     figure(2);
     set(gca,'color','w');
     imagesc(log10(abs(mfcc')));
     axis xy;   %y轴从下往上
     colorbar;
     ylabel('梅尔滤波器组','FontSize',15);
     xlabel('时间 (秒)','FontSize',15);
     title('地震响应梅尔倒谱系数对数图');
set(gca,'FontSize',15)  %是设置刻度字体大小