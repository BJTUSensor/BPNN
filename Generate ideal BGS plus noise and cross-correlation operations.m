
%           Option:生成理想的BGS并加噪声及互相关操作
%           Creator:XIDI
%           Data: 2018/12/16 12:13
%           Last Modified： 2019/5/31 

clc;clear all;close all

% 设置参数
% 线高
    gBu=0.5;
% 中心频率
    vBu=11.05;
% 线宽
    Delta_vBu=100;%MHz
% 扫频范围，采样间隔
    v2 = 10.7:0.0005:11.3;   
        for k=1:length(v2)
            gu(k) = gBu/(1+4*((v2(k)-vBu)/(Delta_vBu*0.001))^2);
        end
    
%     figure;
%     plot(v2,gu,'b-') %未加噪声的曲线

% 加噪声曲线1
    SNR_db = 20;
% 根据文中的噪声定义  
    SNR = power(10,SNR_db/10);
    noise=(1/SNR)*randn(length(gu),1);
    
% 加噪声曲线2
    SNR_db2 = 15;
    SNR2 = power(10,SNR_db2/10);
    noise2=(1/SNR2)*randn(length(gu),1); 
    guuu = gu + noise2';
    v3 = v2+0.1;
      
    guu=gu+noise';
    [yprime params resnorm residual] = lorentzfit(v2,guu);
    [yprime1 params resnorm residual] = lorentzfit(v3,guuu);
    
    x3 = 10.7:0.0005:11.9;
 % 相关操作
    y3 = conv(guu,guuu)/60;
       
    figure;
    plot(v2,guu,'r-');hold on;
    plot(v2,yprime,'k-');  hold on
    % 绘制噪声曲线2
    plot(v3,guuu,'b-');  hold on
    plot(v3,yprime1,'k-');  hold on
    plot(x3,y3,'r');  hold on

    xlim=get(gca,'Xlim'); % 获取当前图形的纵轴的范围
    plot(xlim,[0.5,0.5],'r--','LineWidth',1.5); % 绘制y=0.5的直线
    ylim=get(gca,'Ylim'); % 获取当前图形的纵轴的范围
    plot([11.05,11.05],ylim,'k--','LineWidth',1.5); % 绘制x=11.05的直线
    plot([11.07,11.07],ylim,'k--','LineWidth',1.5); % 绘制x=11.05的直线
    axis([10.9 11.2 -0.2 1.2]);  
    ylabel('Normalized amplitude [a.u.]'); xlabel('Frequency (GHz)');
%   title('XXXXXXXXXXXXXXXXXXXXX');
    hold off;  
    legend('r(SNR=15  Measured Brillouin gain spectrum)','b(SNR=12  Measured Brillouin gain spectrum)');
    