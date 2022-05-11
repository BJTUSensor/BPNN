
%           Option：基于BP神经网络算法提取Brillouin频移信息
%           Creator:XIDI
%           Data: 2018/5/10 9:10
%           Last Modified： 2019/6/14 9:44

    %% 清空环境变量
    clc;clear all;close all
    %% 网络结构建立
    % 导入训练和测试数据
    load HongKong_May_Data

    [n,m]=size(datatrain);
    % 训练数据及对应标记集
    input_train=datatrain(:,1:m-1)';  
    output_train=datatrain(:,m)';
    % 测试数据及对应标记集
    input_test=datatest(:,1:m-1)';
    output_test=datatest(:,m)'; 

    inputn=input_train;
    outputn=output_train;
    % 设置隐含层数
    hiddennum=12;
    %% 初始化BP神经网络
    % 初始化网络中有3个参数可以自己定义
    % 参数1：隐含层传递函数.tansig, logsig 等.
    % 参数2：输出层传递函数.purelin, poslin, satlin, satlins 等.
    % 参数3：训练函数.可以选择：traingd, traingdm, traingda, traingdx, trainlm 等.
    net=newff1(inputn,outputn,hiddennum,{'tansig','satlins'},'trainlm');  
    % 训练梯度
    net.trainParam.lr=0.00001;      
    % 最大训练次数
    net.trainParam.epochs=10000;  
    % 训练性能界
    net.trainParam.goal=1e-4;
    % 最小确认失败次数
    net.trainParam.max_fail = 20;
    % 训练网络
    [net,tr]=train1(net,inputn,outputn);                          
    %% BP神经网络测试及结果
    % 启动计时器，计算程序运行时间
    tic;
    % 输入测试数据检测网络性能
    an=sim(net,input_test);   
    % 计时结束
    toc;
    % 对测试数据检测得到的结果进行处理
    [i,j]=size(an);
    yy=[];
     for i = 1:j
         if  an(1,i) > 0.03;
             yy(i)=1;
          else
             yy(i)=0;
          end
     end
    %% 输出频移的起始位置
    [m,n]=find(yy == 1);
    % 找到频移的起始位置
    a = min(min(n));
    b = max(max(n));
    % 绘制Brillouin频移的起止位置    
    x = 0:50000;
    figure();
    y = (2).*(x>=0 & x< a ) + (4).*(x>= a & x<= b ) + (2).*(x> b & x<=50000);
    plot(x,y,'b','LineWidth',2);

    % 设置二维图的X-Y坐标范围 
    axis([0 50010 0 6]);
    hold on;
    % X和Y坐标的标签
    xlabel('Fiber length [a.u.]'); ylabel('Frequency shift [a.u.]');
    title('BP-neural network edge detection effect chart');
    % Brillouin频移起止位置进行*号标记
    plot( a , 4, '*', 'MarkerEdgeColor','r','MarkerSize',20);
    plot( b , 4, '*', 'MarkerEdgeColor','r','MarkerSize',20);
    hold on;
    % 显示Brillouin的起止位置
    text(a,4,['Start(' num2str(a) ')']);
    text(b,4,['Eed(' num2str(b) ')']);
    hold off;  