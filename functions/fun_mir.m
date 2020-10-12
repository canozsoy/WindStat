function [mirOldGum,mirNewGum,mirFT2,mirW,mirLog]=fun_mir(ROldGum,RNewGum,RFT2,RW,RLog,r,v)
% Gumbel
a=-2.364+(0.54*(v^2.5));
b=-0.2665-(0.0457*(v^2.5));
c=-0.044;
drmGum=exp(a+b*log(r)+c*(log(r)^2));
% 
% FT-II for k=2.5
a=-2.470+(0.015*(v^1.5));
b=-0.1530-(0.0052*(v^2.5));
c=0;
drmFT2(1,1)=exp(a+b*log(r)+c*(log(r)^2));
%
% FT-II for k=3.33
a=-2.462-(0.009*(v^2));
b=-0.1933-(0.0037*(v^2.5));
c=-0.007;
drmFT2(2,1)=exp(a+b*log(r)+c*(log(r)^2));
%
% FT-II for k=5.0
a=-2.463;
b=-0.2110-(0.0131*(v^2.5));
c=-0.019;
drmFT2(3,1)=exp(a+b*log(r)+c*(log(r)^2));
%
% FT-II for k=10.0
a=-2.437+(0.028*(v^2.5));
b=-0.2280-(0.0300*(v^2.5));
c=-0.033;
drmFT2(4,1)=exp(a+b*log(r)+c*(log(r)^2));
%
% Weibull for k=0.75
a=-2.435-(0.168*(v^0.5));
b=-0.2083+(0.1074*(v^0.5));
c=-0.047;
drmW(1,1)=exp(a+b*log(r)+c*(log(r)^2));
%
% Weibull for k=1.0
a=-2.355;
b=-0.2612;
c=-0.043;
drmW(2,1)=exp(a+b*log(r)+c*(log(r)^2));
%
% Weibull for k=1.4
a=-2.277+(0.056*(v^0.5));
b=-0.3169-(0.0499*v);
c=-0.044;
drmW(3,1)=exp(a+b*log(r)+c*(log(r)^2));
%
% Weibull for k=2.0
a=-2.160+(0.113*v);
b=-0.3788-(0.0979*v);
c=-0.041;
drmW(4,1)=exp(a+b*log(r)+c*(log(r)^2));
%
%Lognormal
a=-2.153+0.059*(v)^2;
b=-0.2627-0.1716*(v)^(1/4);
c=-0.045;
drmLog=exp(a+b*log(r)+c*(log(r))^2);
%
mirOldGum=(1-ROldGum)./drmGum;
mirNewGum=(1-RNewGum)./drmGum;
mirFT2=(1-RFT2)./drmFT2;
mirW=(1-RW)./drmW;
mirLog=(1-RLog)./drmLog;


end