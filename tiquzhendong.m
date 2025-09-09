%% txt2mat
clear all;
for day=14:27
   day=10;
filePath=['G:\大胜关数据\2017\6\',num2str(day),'\ZD\JSD-15-07'];
filePath1=['G:\大胜关数据\2017\6\',num2str(day),'\ZD\JSD-15-07'];
fileFolder=fullfile(filePath);
dirOutput=dir(fullfile(fileFolder,'*.txt'));
fileNames={dirOutput.name};
[~,fileCount]=size(fileNames);
T=[];T1=[];
for f=1:fileCount
    in=load([filePath,'\',fileNames{f}]);
    T1=[T1;in];
    %[amount,~]=size(in{1});
    %Path=([filePath1,'\',erase(fileNames{f},'.txt'),'.mat']);
    %save (Path,'T');
end
for g=1:floor(length(T1)/4)
    T(g)=T1(4*g-3);
end

% 短时能量法
% 加载数据
%load('accelerometer_data.mat');
accelerometer_data=T;
Hz=50;
% 高通滤波器设置
[b,a] = butter(4, 2*5/Hz, 'high');
% 进行高通滤波
acc_filt = filter(b,a,accelerometer_data);

% 窗口长度
win_size = 0.5*Hz-1; % 500ms的采样点数，需确保(win_size/2) 取值为整数
%win_size = 5*Hz; % 画图窗口长度

% 计算信号的全局平均值
global_mean = mean(abs(acc_filt));
% 计算短时能量
energy = zeros(size(acc_filt));
for i = 1:length(acc_filt)-win_size
    energy(i+win_size/2) = sum(abs(acc_filt(i:i+win_size-1)).^2);
end
% 判断阈值，得到振动信号出现的时刻
threshold = 5*global_mean;
detection = energy > threshold;
% 让振动信号连续
for i = 1:length(detection)
    if detection(i) == 0 % 如果当前位置是0
        j = i + 1;
        while (j <= length(detection)) && (detection(j) == 0) % 找到连续的0
            j = j + 1;
        end
        if (j - i) < 150 % 如果连续的0的数量小于100
            detection(i:j-1) = 1; % 将这些0替换为1
        end
    end
end
for i = 1:length(detection)
    if detection(i) == 0 % 如果当前位置是0
        j = i + 1;
        while (j <= length(detection)) && (detection(j) == 0) % 找到连续的0
            j = j + 1;
        end
        if (j - i) < 50 % 如果连续的0的数量小于100
            detection(i:j-1) = 1; % 将这些0替换为1
        end
    end
end
% 绘图
% t = (0:length(acc_filt)-1)/Hz; % 时间轴
% figure;
% subplot(2,1,1);
% plot(t, acc_filt);
% title('原始信号');
% subplot(2,1,2);
% plot(t, detection);
% ylim([-0.2, 1.2]);
% title('振动信号检测结果');

% 数据划分元胞
% 定义数组
data = detection;

% 找到连续为1的段的起始和结束索引
start_idx = strfind([0,data], [0 1]);
end_idx = strfind([data,0], [1 0])-1;
len = end_idx - start_idx + 1;

% 找到长度大于1000的段
long_segments1 =1500 < len ;
long_segments2 =2500 > len ;
for i=1:length(len)
    long_segments(1,i)=long_segments1(1,i)&&long_segments2(1,i);
end
start_idx = start_idx(long_segments);
end_idx = end_idx(long_segments);

% 将每个段存储在单独的元胞中
segments = cell(length(start_idx),1);
for i = 1:length(start_idx)
    segments{i} = acc_filt(start_idx(i):end_idx(i));
end

save(['G:\大胜关数据\2017\6\',num2str(day),'\ZD\JSD-20-10.mat'],'segments');
save myfile day;
clear all
load myfile
end
%% 拼接
clear all;
data=cell(1,1);
for day=7:10
        load(['G:\大胜关数据\2017\6\',num2str(day),'\ZD\JSD-02-01.mat'])
        data=[data;segments];
        load(['G:\大胜关数据\2017\6\',num2str(day),'\ZD\JSD-04-02.mat'])
        data=[data;segments];
        load(['G:\大胜关数据\2017\6\',num2str(day),'\ZD\JSD-04-03.mat'])
        data=[data;segments];
        load(['G:\大胜关数据\2017\6\',num2str(day),'\ZD\JSD-11-04.mat'])
        data=[data;segments];
        load(['G:\大胜关数据\2017\6\',num2str(day),'\ZD\JSD-11-05.mat'])
        data=[data;segments];
        load(['G:\大胜关数据\2017\6\',num2str(day),'\ZD\JSD-15-06.mat'])
        data=[data;segments];
        load(['G:\大胜关数据\2017\6\',num2str(day),'\ZD\JSD-15-07.mat'])
        data=[data;segments];
        load(['G:\大胜关数据\2017\6\',num2str(day),'\ZD\JSD-18-08.mat'])
        data=[data;segments];
        load(['G:\大胜关数据\2017\6\',num2str(day),'\ZD\JSD-18-09.mat'])
        data=[data;segments];
end
for day=11:27
        load(['G:\大胜关数据\2017\6\',num2str(day),'\ZD\JSD-02-01.mat'])
        data=[data;segments];
        load(['G:\大胜关数据\2017\6\',num2str(day),'\ZD\JSD-04-02.mat'])
        data=[data;segments];
        load(['G:\大胜关数据\2017\6\',num2str(day),'\ZD\JSD-04-03.mat'])
        data=[data;segments];
        load(['G:\大胜关数据\2017\6\',num2str(day),'\ZD\JSD-11-04.mat'])
        data=[data;segments];
        load(['G:\大胜关数据\2017\6\',num2str(day),'\ZD\JSD-11-05.mat'])
        data=[data;segments];
        load(['G:\大胜关数据\2017\6\',num2str(day),'\ZD\JSD-15-06.mat'])
        data=[data;segments];
        load(['G:\大胜关数据\2017\6\',num2str(day),'\ZD\JSD-18-08.mat'])
        data=[data;segments];
        load(['G:\大胜关数据\2017\6\',num2str(day),'\ZD\JSD-18-09.mat'])
        data=[data;segments];
end
segments= data(~cellfun('isempty', data));
%% 画图
acc=acc_filt;
ene=energy/1000;
acc=acc(1:50000);
ene=ene(1:50000);
% 绘图
t = (1:50000)/Hz; % 时间轴
figure;
subplot(2,1,1);
plot(t, acc);
set(gca,'FontSize',25)  %是设置刻度字体大小
ylabel('加速度（cm/s²）','fontsize',25)
xlabel('时间（s）','fontsize',25)
subplot(2,1,2);
plot(t, ene);
set(gca,'FontSize',25)  %是设置刻度字体大小
ylabel('能量（cm/s²）','fontsize',25)
xlabel('时间（s）','fontsize',25)