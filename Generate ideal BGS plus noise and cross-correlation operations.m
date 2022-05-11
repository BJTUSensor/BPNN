
%           Option:���������BGS��������������ز���
%           Creator:XIDI
%           Data: 2018/12/16 12:13
%           Last Modified�� 2019/5/31 

clc;clear all;close all

% ���ò���
% �߸�
    gBu=0.5;
% ����Ƶ��
    vBu=11.05;
% �߿�
    Delta_vBu=100;%MHz
% ɨƵ��Χ���������
    v2 = 10.7:0.0005:11.3;   
        for k=1:length(v2)
            gu(k) = gBu/(1+4*((v2(k)-vBu)/(Delta_vBu*0.001))^2);
        end
    
%     figure;
%     plot(v2,gu,'b-') %δ������������

% ����������1
    SNR_db = 20;
% �������е���������  
    SNR = power(10,SNR_db/10);
    noise=(1/SNR)*randn(length(gu),1);
    
% ����������2
    SNR_db2 = 15;
    SNR2 = power(10,SNR_db2/10);
    noise2=(1/SNR2)*randn(length(gu),1); 
    guuu = gu + noise2';
    v3 = v2+0.1;
      
    guu=gu+noise';
    [yprime params resnorm residual] = lorentzfit(v2,guu);
    [yprime1 params resnorm residual] = lorentzfit(v3,guuu);
    
    x3 = 10.7:0.0005:11.9;
 % ��ز���
    y3 = conv(guu,guuu)/60;
       
    figure;
    plot(v2,guu,'r-');hold on;
    plot(v2,yprime,'k-');  hold on
    % ������������2
    plot(v3,guuu,'b-');  hold on
    plot(v3,yprime1,'k-');  hold on
    plot(x3,y3,'r');  hold on

    xlim=get(gca,'Xlim'); % ��ȡ��ǰͼ�ε�����ķ�Χ
    plot(xlim,[0.5,0.5],'r--','LineWidth',1.5); % ����y=0.5��ֱ��
    ylim=get(gca,'Ylim'); % ��ȡ��ǰͼ�ε�����ķ�Χ
    plot([11.05,11.05],ylim,'k--','LineWidth',1.5); % ����x=11.05��ֱ��
    plot([11.07,11.07],ylim,'k--','LineWidth',1.5); % ����x=11.05��ֱ��
    axis([10.9 11.2 -0.2 1.2]);  
    ylabel('Normalized amplitude [a.u.]'); xlabel('Frequency (GHz)');
%   title('XXXXXXXXXXXXXXXXXXXXX');
    hold off;  
    legend('r(SNR=15  Measured Brillouin gain spectrum)','b(SNR=12  Measured Brillouin gain spectrum)');
    