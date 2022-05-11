
% This program is used to find out the SNR of a point along the fiber of a
% BOTDA system.
% 
% Noise of point x: noise(x) = y(x) - y1(a, b, c, x); where a, b, c are the
% fitting parameter. Data from FreqShiftAcqV3_for_HK_data.m
% SNR = max(y1(x))/var(noise(x)).
% SNR_dB = 10*log10(SNR).
% 
% Created time: 26/12/2018 by Kuanglu YU, Beijing Jiaotong University

clc;clear all;close all

% load CFM_30C_ave4000  
load CFM_50C_ave4000
load Frequency
load Data

Fitstart = 12700;
Fitstop  = 37131;

A = zeros(3,24431);
 for  i = Fitstart:Fitstop
      A(:,i) = lorentz_fit1(freq,Gain_Bril(:,i));
 end

% yf1n 带noise的测量谱
noisef1n = zeros(N1,N2);
yf1n = zeros(N1,N2);
var_noisef1n = zeros(1,N2);
SNR_f1n = zeros(1,N2);

% yf0n 带noise的参考谱
noisef0n = zeros(N1,N2);
yf0n = zeros(N1,N2);
var_noisef0n = zeros(1,N2);
SNR_f0n = zeros(1,N2);

SNRrange = 2507:2704;

for i = 1:N2
    if xlab(i) > 0 && xlab(i) < l              % Within the fiber area;
%         for j = 1:N1
            yf1n(:,i) = param_fit1n(1,i)./((ylab - param_fit1n(2,i)).^2 + param_fit1n(3,i));
            
            yf0n(:,i) = param_fit0n(1,i)./((ylab - param_fit0n(2,i)).^2 + param_fit0n(3,i));
%         end

        noisef1n(:,i) = yf1n(:,i) - f1n(:,i);
        var_noisef1n(i) = var(noisef1n(:,i));
        SNR_f1n(i) = max(yf1n(:,i))/var_noisef1n(i);
        
        noisef0n(:,i) = yf0n(:,i) - f0n(:,i);
        var_noisef0n(i) = var(noisef0n(:,i));
        SNR_f0n(i) = max(yf0n(:,i))/var_noisef0n(i);
    end
end
SNR_f1n_dB = 10*log10(SNR_f1n);
SNR_f0n_dB = 10*log10(SNR_f0n);

figure;
subplot(221); mesh(xlab,ylab,f1n);
subplot(222); mesh(xlab,ylab,yf1n);
subplot(223); mesh(xlab,ylab,noisef1n);
subplot(224); yyaxis left;plot(xlab, SNR_f1n);yyaxis right; plot(xlab,SNR_f1n_dB);title('SNR for f1n');
avgSNR_f1n = mean(SNR_f1n_dB(SNRrange))

figure;
subplot(221); mesh(xlab,ylab,f0n);
subplot(222); mesh(xlab,ylab,yf0n);
subplot(223); mesh(xlab,ylab,noisef0n);
subplot(224); yyaxis left;plot(xlab, SNR_f0n);yyaxis right; plot(xlab,SNR_f0n_dB);title('SNR for f0n');
avgSNR_f0n = mean(SNR_f0n_dB(SNRrange))