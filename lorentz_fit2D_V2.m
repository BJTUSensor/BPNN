function param_fit = lorentz_fit2D_V2(xlab,ylab,l,spectrum_sub)

% lorentz_fit2D_V1 fits a three-parameter Lorentzian function to 2D data
%
%   The function Y(X) is fit by the model:
%       YPRIME(X) = P1./((X - P2).^2 + P3).
% Created time: 13/07/2017 by Kuanglu YU, Beijing Jiaotong University
% Version 1: 31/07/2017 by Kuanglu YU, Beijing Jiaotong University. If
% there is no fiber, frequency shift is set at 1 MHz, so that noises of 
% outside the fiber range are not considered.
% Version 2: 25/09/2017 by Kuanglu YU, optimized with a new fitting
% alogrithm;

[N1,N2] = size(spectrum_sub);
param_fit = zeros(3,N2);
param0 = zeros(3,N2);
freq_org = 10.8;
errw = zeros(1,N2);

for i = 1:N2
    if xlab(i) < 0                  % Before the fiber;
        param_fit(2,i) = 1;
    elseif xlab(i) > l/1e3       % After the fiber;
        param_fit(2,i) = 1;
    else                          
     param0(3,i) = ((max(ylab)-min(ylab))/1e2)^2;     % HWHM^2
     param0(2,i) = freq_org;                         % Central Freq of second Lorentzian
     param0(1,i) = max(spectrum_sub(:,i))*(max(ylab)-min(ylab))/1e2;      % HWHM*Intensity;
     lorentzeq =  'a/((x - b)^2 + c)';  % function to fit
     startpoint = [param0(1,i) param0(2,i) param0(3,i)];    %Starting values
     Lowerbounds = [0 10 (1e-1/1e3)^2];
     Upperbounds = [1.1 13 (1e3/1e3)^2];
     f1 = fit(ylab',spectrum_sub(:,i),lorentzeq,...
                'Robust','off','Start',startpoint,...
                'Lower',Lowerbounds,'Upper',Upperbounds);   %fit
     param_fit(:,i) = coeffvalues(f1);                      %Fitted coefficients a, d, w, xc.
     err=confint(f1,0.95);
     errw(i)=err(2,2)-err(1,2);
    end    
end