
%           Option：基于边缘检测算法提取Brillouin频移信息
%           Creator:XIDI
%           Data: 2018/4/17 9:47
%           Last Modified： 2019/6/14 09：36

    clc;clear all;close all

    % 滤波的步长
    load Data_Filter_Parameter
    % 导入待检测的数据
    load  Data_Brillouin
    [n,m]=size(Filter_Parameter(3,:));
%% 方案1：先滤波，再相减
    for  i =1:m
        % 获得当前的循环参数
        i
        % 当前过滤参数
        a = Filter_Parameter(i,1);
        F_P = a;
        %  调用Filter函数，对数据进行过滤
        [Original_Spectrum,Measurement_Spectrum,Subtraction_Spectrum,Parameter] = Filter(A1,B1,F_P,'2');
        %  调用EdgeDetection函数，确定原始谱边缘
        [A_Start,A_End] = EdgeDetection(Original_Spectrum);
        %  调用EdgeDetection函数，确定测量谱边缘
        [B_Start,B_End] = EdgeDetection(Measurement_Spectrum);
        %  调用EdgeDetection函数，确定相减谱边缘
        [C_Start,C_End] = EdgeDetection(Subtraction_Spectrum);
        %  结果1：对应的过滤参数
        DE(1,i) = Filter_Parameter(i,1); 
        %  结果2：原始谱开始的位置
        DE(2,i) = A_Start;
        %  结果3：原始谱结束的位置
        DE(3,i) = A_End;
        %  结果4：测量谱开始的位置
        DE(4,i) = B_Start;
        %  结果5：测量谱结束的位置
         DE(5,i) = B_End;
        %  结果6：确定BFS开始的位置
         DE(6,i) = C_Start;
        %  结果7：确定BFS结束的位置
        DE(7,i) = C_End;
        %  结果8：调用误差函数，确定误差
        [Deviation_Parameter,P1,P2] = Deviation(A_Start,A_End,B_Start,B_End,C_Start,C_End,1);
        DE(8,i) = Deviation_Parameter; 
        DE(9,i) = P1; 
        DE(10,i) = P2; 
        dec =DE'; 
    end
%{
            权值函数，不用该函数了
            [Weights_1,Weights_2,Weights_3] = Weights(dec,1); 
            for  i =1:m
            DE(1,:) =[1,11,21,31,41,51,61,71,81,91]; 
            A_Start = dec(i,2);
            A_End = dec(i,3);
            B_Start = dec(i,4);
            B_End = dec(i,5);
            C_Start = dec(i,6);
            C_End = dec(i,7);
            [Deviation_Parameter, Parameter_1, Parameter_2, Parameter_3, Parameter_4, Parameter_5, Parameter_6] = Deviation(A_Start,A_End,B_Start,B_End,C_Start,C_End,Weights_1,Weights_2,Weights_3,1);
            PPP(1,i) = Parameter_1;
            PPP(2,i) = Parameter_2;
            PPP(3,i) = Parameter_3;
            PPP(4,i) = Parameter_4;
            PPP(5,i) = Parameter_5;
            PPP(6,i) = Parameter_6;
            DE(8,i) = Deviation_Parameter; 
            DEC=DE';
        end
%}
%% 方案2：先相减，再滤波
    for  i =1:m
        % 获得当前的循环参数
        i
        % 当前过滤参数
        F_P = Filter_Parameter(i,1);
        %  调用Filter函数，对数据进行过滤
        [Original_Spectrum,Measurement_Spectrum,Subtraction_Spectrum,Parameter] = Filter(A1,B1,F_P,'4');
        %  调用EdgeDetection函数，确定相减谱边缘
        [C_Start,C_End] = EdgeDetection(Subtraction_Spectrum);
        %  结果1：对应的过滤参数
        DE(1,i) =Filter_Parameter(i,1); 
        %  结果2：确定BFS开始的位置
        DE(2,i) = C_Start;
        %  结果3：确定BFS结束的位置
        DE(3,i) = C_End; 
        %  结果4：调用误差函数，确定误差
        Deviation_Parameter = Deviation(0,0,0,0,C_Start,C_End,2);
        DE(8,i) =Deviation_Parameter;
        dec =DE'; 
    end
%{
        
        [Weights_1,Weights_2,Weights_3] = Weights(dec,2); 
         for  i =1:m-2
            C_Start = dec(i,2);
            C_End = dec(i,3);
            Deviation_Parameter = Deviation(0,0,0,0,C_Start,C_End,Weights_1,Weights_2,Weights_3,2);
            DE(4,i) = Deviation_Parameter;
            DEC =DE'; 
        end
%}