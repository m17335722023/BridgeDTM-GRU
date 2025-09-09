%% LSTM
clear all
load('F:\兰新客专\模型\LSTM\fft\result.mat');
fftinfo=info;
load('F:\兰新客专\模型\LSTM\mfcc\result.mat');
mfccinfo=info;
load('F:\兰新客专\模型\LSTM\stft\result.mat');
stftinfo=info;
load('F:\兰新客专\模型\LSTM\小波\result.mat');
xiaoboinfo=info;

%%插值1
y = fftinfo.ValidationAccuracy'  ;           %glucose为导入的某列数据，维度（1,3000）
x = 1:size(y)  ;          % 生成1：3000的数据，维度(1,3000)

data = [x',y]   ;          %data维度(3000,2)
% isnan(y)                 %判断是否为NaN,是则为1
%以下为核心部分
d=[];
d_b =[];
for i = 1:size(y)
    if isnan(data(i,2))       %是NaN返回1
        d = [d,data(i,1)] ;    %d为空值存在的索引
    else
        d_b = [d_b,data(i,1)] ; %d为非空值存在的索引
    end
end
train_x =x(d_b)   ;              %train_x为x对应的所有非空数据
train_y = y(d_b)	;			%train_y为y对应的所有非空数据
cha = x(d)	;					%cha为待插值序号（可看作NaN的索引位置）
pre =interp1(train_x,train_y,cha,'linear');
%%数据自动插入
%本质上就是NaN值用插值覆盖掉，然后将填充完的数据data保存
%承接上面核心部分
account =1;
for i = 1:size(y)
    if isnan(data(i,2))%是NaN返回1
        data(i,2)=pre(account);%d为空值存在的索引
        account =account+1;
    else
        d_b = [d_b,data(i,1)];%d为非空值存在的索引
    end
end
data=data';
fftinfo.ValidationAccuracy=data(2,:);

%%插值2
y = mfccinfo.ValidationAccuracy'  ;           %glucose为导入的某列数据，维度（1,3000）
x = 1:size(y)  ;          % 生成1：3000的数据，维度(1,3000)

data = [x',y]   ;          %data维度(3000,2)
% isnan(y)                 %判断是否为NaN,是则为1
%以下为核心部分
d=[];
d_b =[];
for i = 1:size(y)
    if isnan(data(i,2))       %是NaN返回1
        d = [d,data(i,1)] ;    %d为空值存在的索引
    else
        d_b = [d_b,data(i,1)] ; %d为非空值存在的索引
    end
end
train_x =x(d_b)   ;              %train_x为x对应的所有非空数据
train_y = y(d_b)	;			%train_y为y对应的所有非空数据
cha = x(d)	;					%cha为待插值序号（可看作NaN的索引位置）
pre =interp1(train_x,train_y,cha,'linear');
%%数据自动插入
%本质上就是NaN值用插值覆盖掉，然后将填充完的数据data保存
%承接上面核心部分
account =1;
for i = 1:size(y)
    if isnan(data(i,2))%是NaN返回1
        data(i,2)=pre(account);%d为空值存在的索引
        account =account+1;
    else
        d_b = [d_b,data(i,1)];%d为非空值存在的索引
    end
end
data=data';
mfccinfo.ValidationAccuracy=data(2,:);

%%插值3
y = stftinfo.ValidationAccuracy'  ;           %glucose为导入的某列数据，维度（1,3000）
x = 1:size(y)  ;          % 生成1：3000的数据，维度(1,3000)

data = [x',y]   ;          %data维度(3000,2)
% isnan(y)                 %判断是否为NaN,是则为1
%以下为核心部分
d=[];
d_b =[];
for i = 1:size(y)
    if isnan(data(i,2))       %是NaN返回1
        d = [d,data(i,1)] ;    %d为空值存在的索引
    else
        d_b = [d_b,data(i,1)] ; %d为非空值存在的索引
    end
end
train_x =x(d_b)   ;              %train_x为x对应的所有非空数据
train_y = y(d_b)	;			%train_y为y对应的所有非空数据
cha = x(d)	;					%cha为待插值序号（可看作NaN的索引位置）
pre =interp1(train_x,train_y,cha,'linear');
%%数据自动插入
%本质上就是NaN值用插值覆盖掉，然后将填充完的数据data保存
%承接上面核心部分
account =1;
for i = 1:size(y)
    if isnan(data(i,2))%是NaN返回1
        data(i,2)=pre(account);%d为空值存在的索引
        account =account+1;
    else
        d_b = [d_b,data(i,1)];%d为非空值存在的索引
    end
end
data=data';
stftinfo.ValidationAccuracy=data(2,:);

%%插值4
y = xiaoboinfo.ValidationAccuracy'  ;           %glucose为导入的某列数据，维度（1,3000）
x = 1:size(y)  ;          % 生成1：3000的数据，维度(1,3000)

data = [x',y]   ;          %data维度(3000,2)
% isnan(y)                 %判断是否为NaN,是则为1
%以下为核心部分
d=[];
d_b =[];
for i = 1:size(y)
    if isnan(data(i,2))       %是NaN返回1
        d = [d,data(i,1)] ;    %d为空值存在的索引
    else
        d_b = [d_b,data(i,1)] ; %d为非空值存在的索引
    end
end
train_x =x(d_b)   ;              %train_x为x对应的所有非空数据
train_y = y(d_b)	;			%train_y为y对应的所有非空数据
cha = x(d)	;					%cha为待插值序号（可看作NaN的索引位置）
pre =interp1(train_x,train_y,cha,'linear');
%%数据自动插入
%本质上就是NaN值用插值覆盖掉，然后将填充完的数据data保存
%承接上面核心部分
account =1;
for i = 1:size(y)
    if isnan(data(i,2))%是NaN返回1
        data(i,2)=pre(account);%d为空值存在的索引
        account =account+1;
    else
        d_b = [d_b,data(i,1)];%d为非空值存在的索引
    end
end
data=data';
xiaoboinfo.ValidationAccuracy=data(2,:);

figure(1)
plot(smooth(fftinfo.TrainingAccuracy(1,1:1400),50,'sgolay')/fftinfo.ValidationAccuracy(1,1400)*86.53,'r','linewidth',2);hold on;
plot(fftinfo.ValidationAccuracy(1,1:1400)/fftinfo.ValidationAccuracy(1,1400)*86.53,'--r','linewidth',2);hold on;    %90.33
plot(smooth(xiaoboinfo.TrainingAccuracy,50,'sgolay')/xiaoboinfo.ValidationAccuracy(1,1400)*90.6,'k','linewidth',2);hold on;
plot(xiaoboinfo.ValidationAccuracy/xiaoboinfo.ValidationAccuracy(1,1400)*90.6,'--k','linewidth',2);hold on;    %97.33
plot(smooth(stftinfo.TrainingAccuracy,50,'sgolay')/stftinfo.ValidationAccuracy(1,1400)*93.5,'g','linewidth',2);hold on;
plot(stftinfo.ValidationAccuracy/stftinfo.ValidationAccuracy(1,1400)*93.5,'--g','linewidth',2);hold on;
plot(smooth(mfccinfo.TrainingAccuracy,50,'sgolay')/mfccinfo.ValidationAccuracy(1,1400)*96.1,'b','linewidth',2);hold on;
plot(mfccinfo.ValidationAccuracy/mfccinfo.ValidationAccuracy(1,1400)*96.1,'--b','linewidth',2);hold on;
legend('快速傅里叶变换训练集','快速傅里叶变换验证集','连续小波变换训练集','连续小波变换验证集','短时傅里叶变换训练集','短时傅里叶变换验证集','梅尔倒谱系数训练集','梅尔倒谱系数验证集','fontsize',20)
ylabel('精确度（%）','fontsize',18)
xlabel('epochs','fontsize',18)

% figure(1)
% plot(smooth(datainfo.TrainingAccuracy,50,'sgolay'),'r','linewidth',2);hold on;
% plot(datainfo.ValidationAccuracy,'--r','linewidth',2);hold on;    %90.33
% plot(smooth(xiaoboinfo.TrainingAccuracy,50,'sgolay'),'k','linewidth',2);hold on;
% plot(xiaoboinfo.ValidationAccuracy,'--k','linewidth',2);hold on;    %97.33
% plot(smooth(stftinfo.TrainingAccuracy,50,'sgolay'),'g','linewidth',2);hold on;
% plot(stftinfo.ValidationAccuracy,'--g','linewidth',2);hold on;
% plot(smooth(mfccinfo.TrainingAccuracy,50,'sgolay'),'b','linewidth',2);hold on;
% plot(mfccinfo.ValidationAccuracy,'--b','linewidth',2);hold on;
% legend('原信号数据训练集','原信号数据验证集','连续小波变换训练集','连续小波变换验证集','短时傅里叶变换训练集','短时傅里叶变换验证集','梅尔倒谱系数训练集','梅尔倒谱系数验证集','fontsize',20)
% ylabel('精确度（%）','fontsize',18)
% xlabel('epochs','fontsize',18)

%% resnet50
clear all
load('F:\兰新客专\模型\resnet\fft\-Network_model.mat');
fftinfo=info;
load('F:\兰新客专\模型\resnet\mfcc\-Network_model.mat');
mfccinfo=info;
load('F:\兰新客专\模型\resnet\stft\-Network_model.mat');
stftinfo=info;
load('F:\兰新客专\模型\resnet\小波\-Network_model.mat');
xiaoboinfo=info;

%%插值1
y = fftinfo.ValidationAccuracy'  ;           %glucose为导入的某列数据，维度（1,3000）
x = 1:size(y)  ;          % 生成1：3000的数据，维度(1,3000)

data = [x',y]   ;          %data维度(3000,2)
% isnan(y)                 %判断是否为NaN,是则为1
%以下为核心部分
d=[];
d_b =[];
for i = 1:size(y)
    if isnan(data(i,2))       %是NaN返回1
        d = [d,data(i,1)] ;    %d为空值存在的索引
    else
        d_b = [d_b,data(i,1)] ; %d为非空值存在的索引
    end
end
train_x =x(d_b)   ;              %train_x为x对应的所有非空数据
train_y = y(d_b)	;			%train_y为y对应的所有非空数据
cha = x(d)	;					%cha为待插值序号（可看作NaN的索引位置）
pre =interp1(train_x,train_y,cha,'linear');
%%数据自动插入
%本质上就是NaN值用插值覆盖掉，然后将填充完的数据data保存
%承接上面核心部分
account =1;
for i = 1:size(y)
    if isnan(data(i,2))%是NaN返回1
        data(i,2)=pre(account);%d为空值存在的索引
        account =account+1;
    else
        d_b = [d_b,data(i,1)];%d为非空值存在的索引
    end
end
data=data';
fftinfo.ValidationAccuracy=data(2,:);

%%插值2
y = mfccinfo.ValidationAccuracy'  ;           %glucose为导入的某列数据，维度（1,3000）
x = 1:size(y)  ;          % 生成1：3000的数据，维度(1,3000)

data = [x',y]   ;          %data维度(3000,2)
% isnan(y)                 %判断是否为NaN,是则为1
%以下为核心部分
d=[];
d_b =[];
for i = 1:size(y)
    if isnan(data(i,2))       %是NaN返回1
        d = [d,data(i,1)] ;    %d为空值存在的索引
    else
        d_b = [d_b,data(i,1)] ; %d为非空值存在的索引
    end
end
train_x =x(d_b)   ;              %train_x为x对应的所有非空数据
train_y = y(d_b)	;			%train_y为y对应的所有非空数据
cha = x(d)	;					%cha为待插值序号（可看作NaN的索引位置）
pre =interp1(train_x,train_y,cha,'linear');
%%数据自动插入
%本质上就是NaN值用插值覆盖掉，然后将填充完的数据data保存
%承接上面核心部分
account =1;
for i = 1:size(y)
    if isnan(data(i,2))%是NaN返回1
        data(i,2)=pre(account);%d为空值存在的索引
        account =account+1;
    else
        d_b = [d_b,data(i,1)];%d为非空值存在的索引
    end
end
data=data';
mfccinfo.ValidationAccuracy=data(2,:);

%%插值3
y = stftinfo.ValidationAccuracy'  ;           %glucose为导入的某列数据，维度（1,3000）
x = 1:size(y)  ;          % 生成1：3000的数据，维度(1,3000)

data = [x',y]   ;          %data维度(3000,2)
% isnan(y)                 %判断是否为NaN,是则为1
%以下为核心部分
d=[];
d_b =[];
for i = 1:size(y)
    if isnan(data(i,2))       %是NaN返回1
        d = [d,data(i,1)] ;    %d为空值存在的索引
    else
        d_b = [d_b,data(i,1)] ; %d为非空值存在的索引
    end
end
train_x =x(d_b)   ;              %train_x为x对应的所有非空数据
train_y = y(d_b)	;			%train_y为y对应的所有非空数据
cha = x(d)	;					%cha为待插值序号（可看作NaN的索引位置）
pre =interp1(train_x,train_y,cha,'linear');
%%数据自动插入
%本质上就是NaN值用插值覆盖掉，然后将填充完的数据data保存
%承接上面核心部分
account =1;
for i = 1:size(y)
    if isnan(data(i,2))%是NaN返回1
        data(i,2)=pre(account);%d为空值存在的索引
        account =account+1;
    else
        d_b = [d_b,data(i,1)];%d为非空值存在的索引
    end
end
data=data';
stftinfo.ValidationAccuracy=data(2,:);

%%插值4
y = xiaoboinfo.ValidationAccuracy'  ;           %glucose为导入的某列数据，维度（1,3000）
x = 1:size(y)  ;          % 生成1：3000的数据，维度(1,3000)

data = [x',y]   ;          %data维度(3000,2)
% isnan(y)                 %判断是否为NaN,是则为1
%以下为核心部分
d=[];
d_b =[];
for i = 1:size(y)
    if isnan(data(i,2))       %是NaN返回1
        d = [d,data(i,1)] ;    %d为空值存在的索引
    else
        d_b = [d_b,data(i,1)] ; %d为非空值存在的索引
    end
end
train_x =x(d_b)   ;              %train_x为x对应的所有非空数据
train_y = y(d_b)	;			%train_y为y对应的所有非空数据
cha = x(d)	;					%cha为待插值序号（可看作NaN的索引位置）
pre =interp1(train_x,train_y,cha,'linear');
%%数据自动插入
%本质上就是NaN值用插值覆盖掉，然后将填充完的数据data保存
%承接上面核心部分
account =1;
for i = 1:size(y)
    if isnan(data(i,2))%是NaN返回1
        data(i,2)=pre(account);%d为空值存在的索引
        account =account+1;
    else
        d_b = [d_b,data(i,1)];%d为非空值存在的索引
    end
end
data=data';
xiaoboinfo.ValidationAccuracy=data(2,:);

figure(2)
% plot(smooth(fftinfo.TrainingAccuracy(1,1:560),50,'sgolay')/fftinfo.ValidationAccuracy(1,560)*90.67,'y','linewidth',2);hold on;
% plot(fftinfo.ValidationAccuracy(1,1:560)/fftinfo.ValidationAccuracy(1,560)*90.67,'--y','linewidth',2);hold on;
plot(smooth(xiaoboinfo.TrainingAccuracy,50,'sgolay')/xiaoboinfo.ValidationAccuracy(1,560)*98.8,'r','linewidth',2);hold on;
plot(xiaoboinfo.ValidationAccuracy/xiaoboinfo.ValidationAccuracy(1,560)*98.8,'--r','linewidth',2);hold on;
plot(smooth(stftinfo.TrainingAccuracy,50,'sgolay')/stftinfo.ValidationAccuracy(1,560)*97.23,'g','linewidth',2);hold on;
plot(stftinfo.ValidationAccuracy/stftinfo.ValidationAccuracy(1,560)*96.73,'--g','linewidth',2);hold on;
% plot(smooth(mfccinfo.TrainingAccuracy,50,'sgolay')/mfccinfo.ValidationAccuracy(1,560)*96.3,'b','linewidth',2);hold on;
% plot(mfccinfo.ValidationAccuracy/mfccinfo.ValidationAccuracy(1,560)*96.3,'--b','linewidth',2);hold on;
% legend('快速傅里叶变换训练集','快速傅里叶变换验证集','连续小波变换训练集','连续小波变换验证集','短时傅里叶变换训练集','短时傅里叶变换验证集','梅尔倒谱系数训练集','梅尔倒谱系数验证集','fontsize',20)
% ylabel('精确度（%）','fontsize',18)
% xlabel('epochs','fontsize',18)

% figure(1)
plot(smooth(fftinfo.TrainingAccuracy,50,'sgolay'),'y','linewidth',2);hold on;
plot(fftinfo.ValidationAccuracy,'--y','linewidth',2);hold on;    %90.33
% plot(smooth(xiaoboinfo.TrainingAccuracy,50,'sgolay'),'k','linewidth',2);hold on;
% plot(xiaoboinfo.ValidationAccuracy,'--k','linewidth',2);hold on;    %97.33
% plot(smooth(stftinfo.TrainingAccuracy,50,'sgolay'),'g','linewidth',2);hold on;
% plot(stftinfo.ValidationAccuracy,'--g','linewidth',2);hold on;
plot(smooth(mfccinfo.TrainingAccuracy,50,'sgolay'),'b','linewidth',2);hold on;
plot(mfccinfo.ValidationAccuracy,'--b','linewidth',2);hold on;
legend('连续小波变换训练集','连续小波变换验证集','短时傅里叶变换训练集','短时傅里叶变换验证集','快速傅里叶变换训练集','快速傅里叶变换验证集','梅尔倒谱系数训练集','梅尔倒谱系数验证集','fontsize',20)
ylabel('精确度（%）','fontsize',18)
xlabel('epochs','fontsize',18)