function [HRpData,Lconf,Uconf,PlotData,yVarPlot,LconfPlot,...
    UconfPlot]=fun_montecarlo_log(Atrue,Btrue,RpPlot,mu,sigma,Rp,...
    dataSorted,confInt,lambda,C)
                         
[row,col]=size(dataSorted(:,2)');                                           
for i=1:length(Rp)
    yvar(1,i)=(log(logninv(1-1/Rp(i,1)/lambda,mu,sigma))-mu)/sigma;
end
for i=1:length(RpPlot)
    yplot(1,i)=(log(logninv(1-1/RpPlot(i,1)/lambda,mu,sigma))-mu)/sigma;
end
for k=1:length(RpPlot)
    for i=1:length(Rp)
        if RpPlot(k,1)==Rp(i,1)
            can(1,i)=k;
        end
    end
end                           
for i=1:10000                                                               %MONTE-CARLO SIM. RANDOM NUMBER(MIN 2000)
    random(i,:)=sort(rand(row,col),'descend');
    mu2=mean(random(i,:));
    sigma2=std(random(i,:));
    x(i,:)=sort(Atrue*(log(logninv(random(i,:),...
        mu2,sigma2))-mu2)/sigma2+Btrue,'descend');
    random2(i,:)=rand(row,col);
    x(i,:)=x(i,:)+C*x(i,:).*norminv(random2(i,:),0,1);
    y_new(i,:)=sort(((log(logninv(random(i,:),mu2,sigma2))-...
        mu2)/sigma2),'descend');
    [A(i,:),B(i,:),~]=postreg(x(i,:),y_new(i,:),'hide');
    xr(i,:)=A(i,:)*yplot+B(i,:);
end

[r1,c1]=size(xr);

for i=1:c1
         temp=sort(xr(:,i));
         low_80=ceil(r1*0.10); high_80=ceil(r1*0.90);
         result_80(1,i)=temp(low_80,:);
         result_80(2,i)=temp(high_80,:);
         low_90=ceil(r1*0.05); high_90=ceil(r1*0.95);
         result_90(1,i)=temp(low_90,:);
         result_90(2,i)=temp(high_90,:);
         low_95=ceil(r1*0.025); high_95=ceil(r1*0.975);
         result_95(1,i)=temp(low_95,:);
         result_95(2,i)=temp(high_95,:);
         low_98=ceil(r1*0.01); high_98=ceil(r1*0.99);
         result_98(1,i)=temp(low_98,:);
         result_98(2,i)=temp(high_98,:);
         low_99=ceil(r1*0.005); high_99=ceil(r1*0.995);
         result_99(1,i)=temp(low_99,:);
         result_99(2,i)=temp(high_99,:);
end

XR=exp(Atrue*yplot+Btrue);
yVarPlot=yplot';
PlotData=XR;
HRpData=exp(Atrue*yvar+Btrue)';
if confInt==80
    LconfPlot=exp(result_80(1,:))';
    UconfPlot=exp(result_80(2,:))';
    Lconf=exp(result_80(1,can))';
    Uconf=exp(result_80(2,can))';
end
if confInt==90
    LconfPlot=exp(result_90(1,:))';
    UconfPlot=exp(result_90(2,:))';
    Lconf=exp(result_90(1,can))';
    Uconf=exp(result_90(2,can))';
end
if confInt==95
    LconfPlot=exp(result_95(1,:))';
    UconfPlot=exp(result_95(2,:))';
    Lconf=exp(result_95(1,can))';
    Uconf=exp(result_95(2,can))';
end
if confInt==98
    LconfPlot=exp(result_98(1,:))';
    UconfPlot=exp(result_98(2,:))';
    Lconf=exp(result_98(1,can))';
    Uconf=exp(result_98(2,can));
end
if confInt==99
    LconfPlot=exp(result_99(1,:))';
    UconfPlot=exp(result_99(2,:))';
    Lconf=exp(result_99(1,can))';
    Uconf=exp(result_99(2,can))';
end
end


        

