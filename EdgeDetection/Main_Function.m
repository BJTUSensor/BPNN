
%           Option�����ڱ�Ե����㷨��ȡBrillouinƵ����Ϣ
%           Creator:XIDI
%           Data: 2018/4/17 9:47
%           Last Modified�� 2019/6/14 09��36

    clc;clear all;close all

    % �˲��Ĳ���
    load Data_Filter_Parameter
    % �������������
    load  Data_Brillouin
    [n,m]=size(Filter_Parameter(3,:));
%% ����1�����˲��������
    for  i =1:m
        % ��õ�ǰ��ѭ������
        i
        % ��ǰ���˲���
        a = Filter_Parameter(i,1);
        F_P = a;
        %  ����Filter�����������ݽ��й���
        [Original_Spectrum,Measurement_Spectrum,Subtraction_Spectrum,Parameter] = Filter(A1,B1,F_P,'2');
        %  ����EdgeDetection������ȷ��ԭʼ�ױ�Ե
        [A_Start,A_End] = EdgeDetection(Original_Spectrum);
        %  ����EdgeDetection������ȷ�������ױ�Ե
        [B_Start,B_End] = EdgeDetection(Measurement_Spectrum);
        %  ����EdgeDetection������ȷ������ױ�Ե
        [C_Start,C_End] = EdgeDetection(Subtraction_Spectrum);
        %  ���1����Ӧ�Ĺ��˲���
        DE(1,i) = Filter_Parameter(i,1); 
        %  ���2��ԭʼ�׿�ʼ��λ��
        DE(2,i) = A_Start;
        %  ���3��ԭʼ�׽�����λ��
        DE(3,i) = A_End;
        %  ���4�������׿�ʼ��λ��
        DE(4,i) = B_Start;
        %  ���5�������׽�����λ��
         DE(5,i) = B_End;
        %  ���6��ȷ��BFS��ʼ��λ��
         DE(6,i) = C_Start;
        %  ���7��ȷ��BFS������λ��
        DE(7,i) = C_End;
        %  ���8������������ȷ�����
        [Deviation_Parameter,P1,P2] = Deviation(A_Start,A_End,B_Start,B_End,C_Start,C_End,1);
        DE(8,i) = Deviation_Parameter; 
        DE(9,i) = P1; 
        DE(10,i) = P2; 
        dec =DE'; 
    end
%{
            Ȩֵ���������øú�����
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
%% ����2������������˲�
    for  i =1:m
        % ��õ�ǰ��ѭ������
        i
        % ��ǰ���˲���
        F_P = Filter_Parameter(i,1);
        %  ����Filter�����������ݽ��й���
        [Original_Spectrum,Measurement_Spectrum,Subtraction_Spectrum,Parameter] = Filter(A1,B1,F_P,'4');
        %  ����EdgeDetection������ȷ������ױ�Ե
        [C_Start,C_End] = EdgeDetection(Subtraction_Spectrum);
        %  ���1����Ӧ�Ĺ��˲���
        DE(1,i) =Filter_Parameter(i,1); 
        %  ���2��ȷ��BFS��ʼ��λ��
        DE(2,i) = C_Start;
        %  ���3��ȷ��BFS������λ��
        DE(3,i) = C_End; 
        %  ���4������������ȷ�����
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