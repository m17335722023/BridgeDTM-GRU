clear all
load('F:\兰新客专\数据\随机后的data集.mat');
newData=data;
lieche = cell(length(newData),2);

for tt=1:length(newData)
    tt=83;
    x=newData{tt,1};
    frameSize=150;  %帧长
    N = frameSize;
    inc=75;  %帧移
    p = 32;  %梅尔滤波器个数
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
    bl=1125*log10(1+fl/700);%得到梅尔刻度的最小值 2595
    bh=1125*log10(1+fh/700);%得到梅尔刻度的最大值 2595
    %梅尔坐标范围
    % p=26;%滤波器个数
    B=bh-bl;%梅尔刻度长度
    mm=linspace(0,B,p+2);%规划34个不同的梅尔刻度。但只有32个梅尔滤波器
    fm=700*(10.^(mm/1125)-1);%将Mel频率转换为频率
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
     imagesc(log10(abs(mfcc')));
     axis xy;   %y轴从下往上
     colorbar;
     xlabel('时间(s)');
     ylabel('频率(Hz)');
 yticks(0:4:32);
 yticklabels({'1','4','7','10','13','16','19','22','25'});
 xticks(1:9:19);
 xticklabels(0:15:30);
set(gca,'FontSize',25);
set(0,'defaultfigurecolor','w');
%    mfcc=mapminmax(mfcc',0,1);
%    mfcc=mfcc';
    lieche{tt,1}=mfcc;
    lieche{tt,2}=data{tt,2};
end
data=lieche;
%save('F:\兰新客专\数据\LSTMmfccdata.mat','data');
%% 画图
clear all
load('F:\兰新客专\数据\随机后的data集.mat');
newData=data;
lieche = cell(length(newData),2);

for tt=1:2000
    tt=3;
    x=newData{tt,1};
    frameSize=128;  %帧长
    N = frameSize;
    inc=64;  %帧移
    p = 32;  %梅尔滤波器个数
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
    if data{tt,2}==0
     imagesc(log10(abs(mfcc')));
     axis xy;   %y轴从下往上
     colorbar;
     xlabel('语音分帧帧数');
     ylabel('mfcc参数维数');
     set(gcf,'Position',[0,0,143.36,143.36]);
     set(gca,'Position',[0,0,1,1]);		%去除白边
     axis off;  %关闭坐标
    saveas(gcf,['F:\兰新客专\数据\mfcc图像集\0\image',num2str(tt),'.jpg']); %保存当前窗口的图像
    else
     imagesc(log10(abs(mfcc')));
     axis xy;   %y轴从下往上
     colorbar;
     xlabel('语音分帧帧数');
     ylabel('mfcc参数维数');
     set(gcf,'Position',[0,0,143.36,143.36]);
     set(gca,'Position',[0,0,1,1]);		%去除白边
     axis off;  %关闭坐标
    saveas(gcf,['F:\兰新客专\数据\mfcc图像集\1\image',num2str(tt),'.jpg']); %保存当前窗口的图像
    end
    
%    mfcc=mapminmax(mfcc',0,1);
%    mfcc=mfcc';
    lieche{tt,1}=mfcc;
    lieche{tt,2}=data{tt,2};
end
data=lieche;
%save('F:\兰新客专\数据\LSTMmfccdata.mat','data');
