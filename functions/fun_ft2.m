function [A,B,y,R,Rsqr,zetaUp,zetaLow]=fun_ft2(dataSorted,k,r,v)
num=(1:r)';
alpha=0.44+(0.52/k);
beta=0.12-(0.11/k);
F=1-(num-alpha)./(r+beta);
y=k*(((-log(F)).^(-1/k))-1);
[A,B,R]= postreg(dataSorted(:,2),y,'hide'); % Slope, intercept, R
Rsqr=R^2; 
% DOL CRITERION
% zeta_upper
if k==2.5
            aUp=4.653-(1.076*(v^0.5));
            bUp=-2.047+(0.307*(v^0.5));
            cUp=0.635;
elseif k==3.33
            aUp=3.217-(1.216*(v^0.25));
            bUp=-0.903+(0.294*(v^0.25));
            cUp=0.427;
elseif k==5
            aUp=0.599-(0.038*(v^2));
            bUp=0.518-(0.045*(v^2));
            cUp=0.210;
elseif k==10
            aUp=-0.371+(0.171*(v^2));
            bUp=1.283-(0.133*(v^2));
            cUp=0.045;
end
zetaUp=aUp+(bUp*log(r))+(cUp*(log(r))^2);
%zeta_lower
if k==2.5
            aLow=1.481-(0.126*(v^0.25));
            bLow=-0.331-(0.031*(v^2));
            cLow=0.192;
elseif k==3.33
            aLow=1.025;
            bLow=-0.077-(0.050*(v^2));
            cLow=0.143;
elseif k==5
            aLow=0.700+(0.060*(v^2));
            bLow=0.139-(0.076*(v^2));
            cLow=0.100;
elseif k==10
            aLow=0.424+(0.088*(v^2));
            bLow=0.329-(0.094*(v^2));
            cLow=0.061;
end
zetaLow=aLow+(bLow*log(r))+(cLow*(log(r))^2);
end