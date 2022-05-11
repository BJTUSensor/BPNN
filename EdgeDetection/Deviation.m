
%           Data: 2018/4/17 9:47
%           var = 1   第一种：先滤波，再相减
%           var = 2   第二种：先相减，再滤波
%           求误差函数；
%           Creator:XIDI
%           Last Modified： 2018/4/17 18:09


function [Deviation_Parameter,P1,P2] = Deviation(A_Start,A_End,B_Start,B_End,C_Start,C_End,var);
%% 设置数据
A_Left = 132;
A_Right = 8601;

B_Left = 148;
B_Right = 8580;

C_Left = 6940;
C_Right = 8589;
%% 6个参数：A_Start,A_End,B_Start,B_End,C_Start,C_End;
switch var
    case 1       
%         Parameter_1 = abs((A_End - A_Start)*0.6 - (A_Right - A_Left)*0.6)/((A_Right - A_Left)*0.6);
%         Parameter_2 = abs((B_End - B_Start)*0.6 - (B_Right - B_Left)*0.6)/((B_Right - B_Left)*0.6);
%         Parameter_3 = abs(abs(C_End - C_Start)*0.6 - abs(C_Right - C_Left)*0.6)/abs((C_Right - C_Left)*0.6);

        Parameter_4 = (abs(A_Start - A_Left)*0.6)/5000 + (abs(A_End - A_Right)*0.6)/5000;
        Parameter_5 = (abs(B_Start - B_Left)*0.6)/5000 + (abs(B_End - B_Right)*0.6)/5000;
        
         fenmu = max(abs(C_Start - C_Left)*0.6,abs(C_End - C_Right)*0.6);
        Parameter_6 = (abs(C_Start - C_Left)*0.6)/fenmu + (abs(C_End - C_Right)*0.6)/fenmu;
        
%         disp(Parameter_1);
%         disp(Parameter_2);
%         disp(Parameter_3);
%         disp(Parameter_4);
%         disp(Parameter_5);
%         disp(Parameter_6);        
%         SUM_Deviation = Weights_1*(Parameter_1 + Parameter_4) + Weights_2*(Parameter_2 + Parameter_5) + Weights_3*(Parameter_3 + Parameter_6);
        P1 =  Parameter_4;
        P2 =   Parameter_5;
        SUM_Deviation = Parameter_6;
        Deviation_Parameter = SUM_Deviation;

%% 2个参数:C_Start,C_End;
    case 2    
        Parameter_1 = abs((C_End - C_Start)*0.6 - (C_Right - C_Left)*0.6)/((C_Right - C_Left)*0.6);
        
                fenmu = max(abs(C_Start - C_Left)*0.6,abs(C_End - C_Right)*0.6);
        Parameter_2 = (abs(C_Start - C_Left)*0.6)/fenmu + (abs(C_End - C_Right)*0.6)/fenmu;
        Weights = 1;
        
        
        fenmu = max(abs(C_Start - C_Left)*0.6,abs(C_End - C_Right)*0.6);
        SUM_Deviation = Parameter_2;
        Deviation_Parameter = SUM_Deviation;
end
