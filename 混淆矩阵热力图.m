%% 响应分类
clear;
close all;
clc

% 混淆矩阵
% mat=[468 	272 ; 	132 2128 ];
% mat=[533 	129 ;	67 	2271 ];
% mat=[511 	193 ;	89 	2207 ];
% mat=[569 	87 	;31 	2313 ];
% mat=[473 	263 ;	127 2137 ];
% mat=[477 	55 	;123 	2345 ];
% mat=[493 	161 ;	107 2239 ];
% mat=[553 	59  ;	47 	2341 ];
% mat=[509 	221 ;	91 	2179 ];
% mat=[578 	106 ; 	22 	2294 ];
% mat=[565 	16 	;35 	2384 ];
% mat=[562 	87  ;   38 	2313 ];
% mat=[512 	212 ;	88 	2188 ];
% mat=[584 	82  ;	16 	2318 ];
% mat=[592 	27 	;8 	2373 ];
% mat=[563 	74  ;	37 	2326 ];

% 标签
label = {'地震','列车'};

% 混淆矩阵主题颜色
% 可通过各种拾色器获得rgb色值
%maxcolor = [191,54,12]; % 最大值颜色
%maxcolor = [144,201,231]; % 最大值颜色
maxcolor = [92,147,148]; % 最大值颜色
mincolor = [255,255,255]; % 最小值颜色

% 绘制坐标轴
m = length(mat);
imagesc(1:m,1:m,mat);
xticks(1:m)
xlabel('真实分类','fontsize',20)
xticklabels(label)
yticks(1:m)
ylabel('预测分类','fontsize',20)
yticklabels(label)

% 构造渐变色
mymap = [linspace(mincolor(1)/255,maxcolor(1)/255,64)',...
         linspace(mincolor(2)/255,maxcolor(2)/255,64)',...
         linspace(mincolor(3)/255,maxcolor(3)/255,64)'];

colormap(mymap)
colorbar()
caxis([0,2500])
% 色块填充数字
for i = 1:m
    for j = 1:m
        text(i,j,num2str(mat(j,i)),...
            'horizontalAlignment','center',...
            'verticalAlignment','middle',...
            'fontname','Times New Roman',...
            'fontsize',20);
    end
end

% 图像坐标轴等宽
ax = gca;
ax.FontName = 'Helvetica';
set(gca,'box','on','xlim',[0.5,m+0.5],'ylim',[0.5,m+0.5],'fontsize',20);
axis square

% 保存
%saveas(gca,'m.png');
%% 评估预测测试集
clear;
close all;
clc

% 混淆矩阵

% mat=[46	5	0;5	35	6;0	3	20];
% mat=[48	4	0;5	35	5;0	3	20];
% mat=[49	1	0;2	41	2;0	1	24];
% mat=[51	1	0;2	40	3;0	1	22];


% 标签
label = {'Ⅰ','Ⅱ','Ⅲ'};

% 混淆矩阵主题颜色
% 可通过各种拾色器获得rgb色值
%maxcolor = [191,54,12]; % 最大值颜色
%maxcolor = [144,201,231]; % 最大值颜色
maxcolor = [92,147,148]; % 最大值颜色
mincolor = [255,255,255]; % 最小值颜色

% 绘制坐标轴
m = length(mat);
imagesc(1:m,1:m,mat);
xticks(1:m)
xlabel('真实分类','fontsize',20)
xticklabels(label)
yticks(1:m)
ylabel('预测分类','fontsize',20)
yticklabels(label)

% 构造渐变色
mymap = [linspace(mincolor(1)/255,maxcolor(1)/255,64)',...
         linspace(mincolor(2)/255,maxcolor(2)/255,64)',...
         linspace(mincolor(3)/255,maxcolor(3)/255,64)'];

colormap(mymap)
colorbar()
caxis([0,60])
% 色块填充数字
for i = 1:m
    for j = 1:m
        text(i,j,num2str(mat(j,i)),...
            'horizontalAlignment','center',...
            'verticalAlignment','middle',...
            'fontname','Times New Roman',...
            'fontsize',20);
    end
end

% 图像坐标轴等宽
ax = gca;
ax.FontName = 'Helvetica';
set(gca,'box','on','xlim',[0.5,m+0.5],'ylim',[0.5,m+0.5],'fontsize',20);
axis square

% 保存
%saveas(gca,'m.png');
%% 评估预测训练集
clear;
close all;
clc

% 混淆矩阵

% mat=[96	8	0;9	71	7;0	4	45];
% mat=[97	8	0;7	73	7;0	3	45];
% mat=[103	3	0;2	77	3;0	3	49];
% mat=[103	2	0;1	80	5;0	2	47];

% 标签
label = {'Ⅰ','Ⅱ','Ⅲ'};

% 混淆矩阵主题颜色
% 可通过各种拾色器获得rgb色值
%maxcolor = [191,54,12]; % 最大值颜色
%maxcolor = [144,201,231]; % 最大值颜色
maxcolor = [92,147,148]; % 最大值颜色
mincolor = [255,255,255]; % 最小值颜色

% 绘制坐标轴
m = length(mat);
imagesc(1:m,1:m,mat);
xticks(1:m)
xlabel('真实分类','fontsize',20)
xticklabels(label)
yticks(1:m)
ylabel('预测分类','fontsize',20)
yticklabels(label)

% 构造渐变色
mymap = [linspace(mincolor(1)/255,maxcolor(1)/255,64)',...
         linspace(mincolor(2)/255,maxcolor(2)/255,64)',...
         linspace(mincolor(3)/255,maxcolor(3)/255,64)'];

colormap(mymap)
colorbar()
caxis([0,120])
% 色块填充数字
for i = 1:m
    for j = 1:m
        text(i,j,num2str(mat(j,i)),...
            'horizontalAlignment','center',...
            'verticalAlignment','middle',...
            'fontname','Times New Roman',...
            'fontsize',20);
    end
end

% 图像坐标轴等宽
ax = gca;
ax.FontName = 'Helvetica';
set(gca,'box','on','xlim',[0.5,m+0.5],'ylim',[0.5,m+0.5],'fontsize',20);
axis square

% 保存
%saveas(gca,'m.png');