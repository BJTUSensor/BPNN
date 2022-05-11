
% 设置峰值
gBu=1;
% 设置中心频率
%vBu=10.82891;
Slope = 0.00092924;
% 设置线宽
% Delta_vBu=100;
v2 = 10.751:0.001:10.95;   %扫频范围10.751~10.96，间隔1MHz
% Delta_vBu:线宽
Delta_vBu = 50
% i_2: 温度
temp = 25:0.5:33;

for N=1:10;
   vBu = temp(N) * Slope + 10.805685;
   for k=1:length(v2)
       gu(k) = gBu/(1+4*((v2(k)-vBu)/(Delta_vBu*0.001))^2);   
   end
   gu = gu(:,1:length(v2));
   
   %%添加噪声
   % i_3: SNR
   SNR_db = 1;
   %噪声定义
   SNR = power(10,SNR_db/10);
   Cur =(1/SNR)*randn(length(gu),1);
   
   transition(N,:) = gu+Cur';    
   N = N+1
end

Traindata = reshape(transition,[],200);

figure          %重新开辟一个窗口
mesh(Traindata);

%save('TRAIN_May2019.mat','Traindata','Trainmark');  %保存文件
