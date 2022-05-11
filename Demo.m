
% ���÷�ֵ
gBu=1;
% ��������Ƶ��
%vBu=10.82891;
Slope = 0.00092924;
% �����߿�
% Delta_vBu=100;
v2 = 10.751:0.001:10.95;   %ɨƵ��Χ10.751~10.96�����1MHz
% Delta_vBu:�߿�
Delta_vBu = 50
% i_2: �¶�
temp = 25:0.5:33;

for N=1:10;
   vBu = temp(N) * Slope + 10.805685;
   for k=1:length(v2)
       gu(k) = gBu/(1+4*((v2(k)-vBu)/(Delta_vBu*0.001))^2);   
   end
   gu = gu(:,1:length(v2));
   
   %%�������
   % i_3: SNR
   SNR_db = 1;
   %��������
   SNR = power(10,SNR_db/10);
   Cur =(1/SNR)*randn(length(gu),1);
   
   transition(N,:) = gu+Cur';    
   N = N+1
end

Traindata = reshape(transition,[],200);

figure          %���¿���һ������
mesh(Traindata);

%save('TRAIN_May2019.mat','Traindata','Trainmark');  %�����ļ�
