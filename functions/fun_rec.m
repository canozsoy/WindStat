function [recGum,recFT2,recW,recLog]=fun_rec(r,v)
% Gumbel
a=-1.444;
b=-0.2733-(0.0414*(v^2.5));
c=-0.045;
recGum=exp(a+b*log(r)+c*(log(r)^2));
% 
% FT-II for k=2.5
a=-1.122-(0.037*v);
b=-0.3298+(0.0105*(v^0.25));
c=0.016;
recFT2(1,1)=exp(a+b*log(r)+c*(log(r)^2));
%
% FT-II for k=3.33
a=-1.306-(0.105*(v^1.5));
b=-0.3001+(0.0404*(v^0.5));
c=0;
recFT2(2,1)=exp(a+b*log(r)+c*(log(r)^2));
%
% FT-II for k=5.0
a=-1.463-(0.107*(v^1.5));
b=-0.2716+(0.0517*(v^0.25));
c=-0.018;
recFT2(3,1)=exp(a+b*log(r)+c*(log(r)^2));
%
% FT-II for k=10.0
a=-1.490-(0.073*v);
c=-0.034;
recFT2(4,1)=exp(a+b*log(r)+c*(log(r)^2));
%
% Weibull for k=0.75
a=-1.473-(0.049*(v^2));
b=-0.2181+(0.0505*v);
c=-0.041;
recW(1,1)=exp(a+b*log(r)+c*(log(r)^2));
%
% Weibull for k=1.0
a=-1.433;
b=-0.2679;
c=-0.044;
recW(2,1)=exp(a+b*log(r)+c*(log(r)^2));
%
% Weibull for k=1.4
a=-1.312;
b=-0.3356-(0.0449*v);
c=-0.045;
recW(3,1)=exp(a+b*log(r)+c*(log(r)^2));
%
% Weibull for k=2.0
a=-1.188+(0.073*(v^0.5));
b=-0.4401-(0.0846*(v^1.5));
c=-0.039;
recW(4,1)=exp(a+b*log(r)+c*(log(r)^2));
%
% Lognormal
a=-1.362+0.36*(v)^(1/2);
b=-0.3439-0.2185*(v)^(1/2);
c=-0.035;
recLog=exp(a+b*log(r)+c*(log(r))^2);
%
end