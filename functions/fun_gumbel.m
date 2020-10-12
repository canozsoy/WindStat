function [A,B,y,R,Rsqr,zetaUp,zetaLow]= fun_gumbel(dataSorted,alpha,beta,r,v)
num=(1:r)';
F=1-(num-alpha)./(r+beta);    % non exceedence probability
y=-log(-log(F)); % variate of F
[A,B,R]= postreg(dataSorted(:,2),y,'hide'); % Slope, intercept, R
Rsqr=R^2;
% DOL CRITERION
% zeta_upper
aUp=-0.579+(0.468*v);
bUp=1.496-(0.227*(v^2));
cUp=-0.038;
zetaUp=aUp+(bUp*log(r))+(cUp*(log(r))^2);
%
% zeta_lower
aLow=0.257+(0.133*(v^2));
bLow=0.452-(0.118*(v^2));
cLow=0.032;
zetaLow=aLow+(bLow*log(r))+(cLow*(log(r))^2);
end