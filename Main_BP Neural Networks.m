
%           Option������BP�������㷨��ȡBrillouinƵ����Ϣ
%           Creator:XIDI
%           Data: 2018/5/10 9:10
%           Last Modified�� 2019/6/14 9:44

    %% ��ջ�������
    clc;clear all;close all
    %% ����ṹ����
    % ����ѵ���Ͳ�������
    load HongKong_May_Data

    [n,m]=size(datatrain);
    % ѵ�����ݼ���Ӧ��Ǽ�
    input_train=datatrain(:,1:m-1)';  
    output_train=datatrain(:,m)';
    % �������ݼ���Ӧ��Ǽ�
    input_test=datatest(:,1:m-1)';
    output_test=datatest(:,m)'; 

    inputn=input_train;
    outputn=output_train;
    % ������������
    hiddennum=12;
    %% ��ʼ��BP������
    % ��ʼ����������3�����������Լ�����
    % ����1�������㴫�ݺ���.tansig, logsig ��.
    % ����2������㴫�ݺ���.purelin, poslin, satlin, satlins ��.
    % ����3��ѵ������.����ѡ��traingd, traingdm, traingda, traingdx, trainlm ��.
    net=newff1(inputn,outputn,hiddennum,{'tansig','satlins'},'trainlm');  
    % ѵ���ݶ�
    net.trainParam.lr=0.00001;      
    % ���ѵ������
    net.trainParam.epochs=10000;  
    % ѵ�����ܽ�
    net.trainParam.goal=1e-4;
    % ��Сȷ��ʧ�ܴ���
    net.trainParam.max_fail = 20;
    % ѵ������
    [net,tr]=train1(net,inputn,outputn);                          
    %% BP��������Լ����
    % ������ʱ���������������ʱ��
    tic;
    % ����������ݼ����������
    an=sim(net,input_test);   
    % ��ʱ����
    toc;
    % �Բ������ݼ��õ��Ľ�����д���
    [i,j]=size(an);
    yy=[];
     for i = 1:j
         if  an(1,i) > 0.03;
             yy(i)=1;
          else
             yy(i)=0;
          end
     end
    %% ���Ƶ�Ƶ���ʼλ��
    [m,n]=find(yy == 1);
    % �ҵ�Ƶ�Ƶ���ʼλ��
    a = min(min(n));
    b = max(max(n));
    % ����BrillouinƵ�Ƶ���ֹλ��    
    x = 0:50000;
    figure();
    y = (2).*(x>=0 & x< a ) + (4).*(x>= a & x<= b ) + (2).*(x> b & x<=50000);
    plot(x,y,'b','LineWidth',2);

    % ���ö�άͼ��X-Y���귶Χ 
    axis([0 50010 0 6]);
    hold on;
    % X��Y����ı�ǩ
    xlabel('Fiber length [a.u.]'); ylabel('Frequency shift [a.u.]');
    title('BP-neural network edge detection effect chart');
    % BrillouinƵ����ֹλ�ý���*�ű��
    plot( a , 4, '*', 'MarkerEdgeColor','r','MarkerSize',20);
    plot( b , 4, '*', 'MarkerEdgeColor','r','MarkerSize',20);
    hold on;
    % ��ʾBrillouin����ֹλ��
    text(a,4,['Start(' num2str(a) ')']);
    text(b,4,['Eed(' num2str(b) ')']);
    hold off;  