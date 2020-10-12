function [A,B,z,R,Rsqr,zetaUp,zetaLow,mu,sigma] = fun_lognormal(dataSorted,alpha,beta,r,v)
num=(1:r)';
x=log(dataSorted(:,2));
F=1-(num-alpha)/(r+beta);
mu=mean(x);
sigma=std(x);
z=(log(logninv(F,mu,sigma))-mu)/sigma;
[A,B,R]=postreg(x,z,'hide');
Rsqr=R^2;
%DOL CRITERION
%zeta upper
aUp=0.178+0.74*v;
bUp=1.148-0.48*(v)^(3/2);
cUp=-0.035;
zetaUp=aUp+bUp*log(r)+cUp*(log(r))^2;
%zeta lower
aLow=0.042+0.270*v;
bLow=0.581-0.217*(v)^(3/2);
cLow=0;
zetaLow=aLow+bLow*log(r)+cLow*(log(r))^2;

end

