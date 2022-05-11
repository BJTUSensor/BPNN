
%           Option:Program to generate an ideal BGS
%           Ref.A Detailed Evaluation of the Correlation-Based Method Used for 
%                    Estimation of the Brillouin Frequency Shift in BOTDA Sensors��Formula 1 
%           Creator:XIDI
%           Data: 2019/5/26 21:45
clc;clear all;close all
%% ����ѵ����
clc;clear all;close all

% ���÷�ֵ
gBu=1;
% ��������Ƶ��
vBu=10.86;
Slope = 0.0008622;
% �����߿�
% Delta_vBu=100;
v2 = 10.751:0.001:10.95;   %ɨƵ��Χ10.761~10.96�����1MHz
N = 1;
% Delta_vBu:�߿�
 Delta_vBu = 20:75
% i_2: �¶�
 for i_2 = 20:75

       vBu = i_2 * Slope + 10.86;
       for k=1:length(v2)
            gu(k) = gBu/(1+4*((v2(k)-vBu)/(Delta_vBu*0.001))^2);   
       end

       % i_3: SNR
       for i_3 = 3:40
            SNR_db = i_3;
            %��������
            SNR = power(10,SNR_db/10);
            Cur =(1/SNR)*randn(length(gu),1);
            Result(N,:) = gu;    
            N = N+1
       end      
 end

% ���ƾ���
result = repmat(Cur, 10, 1); 

B = reshape(result,[],200);
% �ϲ�cell����
Result_1 = cell2mat(Result(1:end,:)');
%% ����ѵ����Ӧ���
%% ���ɣ�ѵ�����ı�Ǽ�
%Mark_A = [19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,];

%for j = 1:56
%    c(:,j) =  Mark_A + j;
%end
%B = reshape(c,[],1);
%mesh(B)
%result = repmat(B, 56, 1); 
% Result_2 = cell2mat(c(1:end,:));

%save('TRAIN_May2019.mat','Result_1','Result_2');