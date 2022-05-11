function param_fit = lorentz_fit1(ylab,curve)

% lorentz_fit1 fits a three-parameter Lorentzian function to data
% Revised from Lorentz_fit3D
%   The function Y(X) is fit by the model:
%       YPRIME(X) = P1./((X - P2).^2 + P3).
% Created time: 30/07/2017 by Kuanglu YU, Beijing Jiaotong University

% rough guess of initial parameters
%     param0(4,i) = (max(f1(:,i))+min(f1(:,i)))/2;   
    param0(3) = ((max(ylab)-min(ylab))/10)^2;
    param0(2) = (max(ylab)+min(ylab))/2;
    param0(1) = max(curve)*param0(3);

% define lorentz inline, instead of in a separate file
    lorentz = @(param, x) param(1) ./ ((x-param(2)).^2 + param(3));... + param(4);

% define objective function, this captures X and Y
    fit_error = @(param) sum((curve - lorentz(param, ylab')).^2);
% upper and lower boundary are needed.

% do the fit
     param_fit = fminsearch(fit_error, param0);
    
