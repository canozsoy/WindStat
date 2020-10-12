function [A,B,y,R,Rsqr,zetaUp,zetaLow]=fun_weibull(dataSorted,k,r,v)
num=(1:r)';
alpha=0.20+(0.27/(k^0.5));
beta=0.20+(0.23/(k^0.5));
F=1-(num-alpha)/(r+beta);
y=(-log(1-F)).^(1/k);
[A,B,R]= postreg(dataSorted(:,2),y,'hide'); % Slope, intercept, R
Rsqr=R^2; 
% DOL CRITERION
% zeta_upper
if k==0.75
            aUp=-0.256-(0.632*(v^2));
            bUp=1.269+(0.254*(v^2));
            cUp=0.037;
elseif k==1
            aUp=-0.682;
            bUp=1.600;
            cUp=-0.045;
elseif k==1.4
            aUp=-0.548+(0.452*(v^0.5));
            bUp=1.521-(0.184*v);
            cUp=-0.065;
elseif k==2
            aUp=-0.322+(0.641*(v^0.5));
            bUp=1.414-(0.326*v);
            cUp=-0.069;
end
zetaUp=aUp+(bUp*log(r))+(cUp*(log(r))^2);
%zeta_lower
if k==0.75
            aLow=0.534-(0.162*v);
            bLow=0.277+(0.095*v);
            cLow=0.065;
elseif k==1
            aLow=0.308;
            bLow=0.423;
            cLow=0.037;
elseif k==1.4
            aLow=0.192+(0.126*(v^1.5));
            bLow=0.501-(0.081*(v^1.5));
            cLow=0.018;
elseif k==2
            aLow=0.050+(0.182*(v^1.5));
            bLow=0.592-(0.139*(v^1.5));
            cLow=0;
end
zetaLow=aLow+(bLow*log(r))+(cLow*(log(r))^2);
end