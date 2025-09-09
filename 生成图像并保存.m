clear all
load('F:\兰新客专\数据\dizhen307_mfcc.mat');
for i=1:length(dizhen)
    imagesc(log10(abs(dizhen{i,1}')));
    axis xy;   %y轴从下往上
    colorbar;
    xlabel('语音分帧帧数');
    ylabel('mfcc参数维数');
    saveas(gcf,['F:\兰新客专\数据\dizhen307\image',num2str(i+235),'.jpg']); %保存当前窗口的图像
end