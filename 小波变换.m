clear all
load('F:\兰新客专\数据\随机后的data集.mat');
cell_array(:,1)=data(:,1);
%cell_array(:,1)=newData(:,1);
FREQ=centfrq('morl');
fs=50;

%for i = 1:numel(cell_array)
for i = 1:2000
    i=1534;
    vibration_data = cell_array{i, 1};
    
    t =5:5:30;
    hz=[25:-0.1:0.1];
    scales =FREQ*fs./hz;      
    %scales=1:1:100;
    coefs=cwt(vibration_data,scales,'morl');
    F=scal2frq(scales,'morl',0.02);
    imagesc(t,F,abs(coefs));
    set(gca, 'YDir', 'normal');
    colormap(jet);
    colorbar;
    xlabel('时间(s)');
    ylabel('频率（Hz）');
%    title('小波时频图');
data{i,1}=coefs;
end
%% 画图
clear all
load('F:\兰新客专\数据\随机后的data集.mat');
cell_array(:,1)=data(:,1);
%cell_array(:,1)=newData(:,1);
FREQ=centfrq('morl');
fs=50;

%for i = 1:numel(cell_array)
for i = 1:2000  
    vibration_data = cell_array{i, 1};
    
    t =5:5:30;
    hz=[15:-0.1:0.1];
    scales =FREQ*fs./hz;      
    %scales=1:1:100;
    coefs=cwt(vibration_data,scales,'morl');
    F=scal2frq(scales,'morl',0.02);
    if data{i,2}==0
    imagesc(t,F,abs(coefs));
    set(gca, 'YDir', 'normal');
    colormap(jet);
    colorbar;
    xlabel('时间');
    ylabel('频率（Hz）');
    title('小波时频图');
     set(gcf,'Position',[0,0,143.36,143.36]);
     set(gca,'Position',[0,0,1,1]);		%去除白边
     axis off;  %关闭坐标
    saveas(gcf,['F:\兰新客专\数据\小波图像集\0\image',num2str(i),'.jpg']); %保存当前窗口的图像
    else
    imagesc(t,F,abs(coefs));
    set(gca, 'YDir', 'normal');
    colormap(jet);
    colorbar;
    xlabel('时间');
    ylabel('频率（Hz）');
    title('小波时频图');
     set(gcf,'Position',[0,0,143.36,143.36]);
     set(gca,'Position',[0,0,1,1]);		%去除白边
     axis off;  %关闭坐标
    saveas(gcf,['F:\兰新客专\数据\小波图像集\1\image',num2str(i),'.jpg']); %保存当前窗口的图像
    end
data{i,1}=coefs;
end
