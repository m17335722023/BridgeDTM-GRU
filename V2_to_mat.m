clear all;
filePath1='F:\CESMD地震数据\CESMD地震数据';
fileFolder1=fullfile(filePath1);
dirOutput1=dir(fullfile(fileFolder1));
fileNames1={dirOutput1.name};
[~,fileCount1]=size(fileNames1);

DATA={};

for f1=3:fileCount1
    filePath2=[filePath1,'\',fileNames1{f1}];
    fileFolder2=fullfile(filePath2);
    dirOutput2=dir(fullfile(fileFolder2,'*.V2'));
    fileNames2={dirOutput2.name};
    [~,fileCount2]=size(fileNames2);
    
    for f2=1:fileCount2
        fid = fopen([filePath2,'\',fileNames2{f2}],'r');
        Hz=textscan(fid, '%d %s %s %s %s %s %s %s %f', 1, 'Headerlines', 45); % 读取数据点数量和采样频率
        y=8;  x=Hz{1,1};  row=ceil(x/y); 
        in=textscan(fid, '%f %f %f %f %f %f %f %f', row, 'Headerlines', 1); %读取加速度数据
        fclose(fid);
         switch(Hz{1,9}) % 调整采样频率
             case 0.02 
                data=[in{1,1},in{1,2},in{1,3},in{1,4},in{1,5},in{1,6},in{1,7},in{1,8}];
             case 0.01
                data=[in{1,1},in{1,3},in{1,5},in{1,7}];
             case 0.005
                data=[in{1,1},in{1,5}];
             otherwise
                data=[];
         end
        data= reshape(data',1,[]);data=data(~isnan(data)); %将矩阵转化为一行，去除行末的NAN

        DATA{f1-2,f2}=data;

    end
end