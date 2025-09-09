clear all

%总的指标
% load('D:\5\AFS数据集.mat');
% delta=[S42;S121;S161];
% F=[F42;F121;F161];

%预测指标
load('D:\文件\硕士\毕业论文\Opensees模型数据\模型\S42.mat');
load('D:\文件\硕士\毕业论文\Opensees模型数据\模型\S121.mat');
load('D:\文件\硕士\毕业论文\Opensees模型数据\模型\S161.mat');
load('D:\文件\硕士\毕业论文\Opensees模型数据\模型\F42.mat');
load('D:\文件\硕士\毕业论文\Opensees模型数据\模型\F121.mat');
load('D:\文件\硕士\毕业论文\Opensees模型数据\模型\F161.mat');
delta1=[S42Test;S121Test;S161Test];
F1=[F42Test;F121Test;F161Test];
delta2=[S42Pred;S121Pred;S161Pred];
F2=[F42Pred;F121Pred;F161Pred];

delta2=3*(delta2-delta1)+delta1;
F2=3*(F2-F1)+F1;

% beta=0.1388;
beta=0.1;
deltau=5;
deltay=1.75;

D = zeros(size(delta1,1),2);
label= zeros(size(delta1,1),2);

for i = 1:size(delta1,1)
    D(i,1) = max(delta1(i,:))/ deltau + (beta/deltau)*(0.5*deltay+2.32*(max(delta1(i,:))-deltay));
end

for i = 1:size(delta2,1)
    D(i,2) = max(delta2(i,:))/ deltau + (beta/deltau)*(0.5*deltay+2.32*(max(delta2(i,:))-deltay));
end

for i=1:size(delta1,1)
    if D(i,1)>1
        D(i,1)=0.85;
    end
    if D(i,1)<0
        D(i,1)=0.05;
    end
end

for i=1:size(delta2,1)
    if D(i,2)>1
        D(i,2)=0.85;
    end
    if D(i,2)<0
        D(i,2)=0.05;
    end
end

for i=1:size(delta1,1)
    if D(i,1)<0.25
       label(i,1)=1; 
    else if D(i,1)>=0.5
       label(i,1)=3;
        else
          label(i,1)=2;  
        end
    end
end

for i=1:size(delta2,1)
    if D(i,2)<0.25
       label(i,2)=1; 
    else if D(i,2)>=0.5
       label(i,2)=3;
        else
          label(i,2)=2;  
        end
    end
end

% edges=[0,0.25,0.5,1];
% histogram(D,edges);

label=categorical(label);

%  figure %创建混淆矩阵图
  cm = confusionchart(label(:,1),label(:,2));
%%
clear all

%总的指标
% load('D:\5\AFS数据集.mat');
% delta1=[S42;S121;S161];
% F1=[F42;F121;F161];

%预测指标
load('D:\文件\硕士\毕业论文\Opensees模型数据\模型\S42.mat');
load('D:\文件\硕士\毕业论文\Opensees模型数据\模型\S121.mat');
load('D:\文件\硕士\毕业论文\Opensees模型数据\模型\S161.mat');
load('D:\文件\硕士\毕业论文\Opensees模型数据\模型\F42.mat');
load('D:\文件\硕士\毕业论文\Opensees模型数据\模型\F121.mat');
load('D:\文件\硕士\毕业论文\Opensees模型数据\模型\F161.mat');
delta1=[S42Test;S121Test;S161Test];
F1=[F42Test;F121Test;F161Test];
delta2=[S42Pred;S121Pred;S161Pred];
F2=[F42Pred;F121Pred;F161Pred];

delta2=3*(delta2-delta1)+delta1;
F2=3*(F2-F1)+F1;

% delta=S42Pred;
% F=F42Pred;

%beta=0.1388;
beta=0.1;
deltau=5;
Fy=10000;

D = zeros(size(delta1,1),2);
E = zeros(size(delta1,1),2);
Ei = zeros(size(delta1,2),1);

for j=1:size(delta1,1)
    for i = 2:size(delta1,2)
        Ei(i) = Ei(i-1) + 0.5 * (F1(j,i) + F1(j,(i-1))) * (delta1(j,i) - delta1(j,(i-1)));
    end  
    E(j,1)= Ei(size(delta1,1));
end

for j=1:size(delta2,1)
    for i = 2:size(delta2,2)
        Ei(i) = Ei(i-1) + 0.5 * (F2(j,i) + F2(j,(i-1))) * (delta2(j,i) - delta2(j,(i-1)));
    end  
    E(j,2)= Ei(size(delta2,1));
end

for i = 1:size(delta1,1)
    D(i,1) = max(delta1(i,:))/ deltau + beta * E(i,1) / (Fy * deltau);
end

for i = 1:size(delta2,1)
    D(i,2) = max(delta2(i,:))/ deltau + beta * E(i,2) / (Fy * deltau);
end

for i=1:size(delta1,1)
    if D(i,1)<0.25
       label(i,1)=1; 
    else if D(i,1)>=0.445
       label(i,1)=3;
        else
          label(i,1)=2;  
        end
    end
end

for i=1:size(delta2,1)
    if D(i,2)<0.25
       label(i,2)=1; 
    else if D(i,2)>=0.445
       label(i,2)=3;
        else
          label(i,2)=2;  
        end
    end
end

% 整体分布
% edges=[0,0.25,0.5,1];
% histogram(D,edges);

label=categorical(label);

%  figure %创建混淆矩阵图
cm = confusionchart(label(:,1),label(:,2));

% % 假设x和y包含了滞回曲线上的点
% x = S42; % x_values是一个包含x坐标的向量
% y = F42; % y_values是一个包含y坐标的向量
%  
% % 使用trapz进行数值积分计算面积
% area = trapz(x, y);
% 
% % 显示面积
% disp(['面积是: ', num2str(area)]);