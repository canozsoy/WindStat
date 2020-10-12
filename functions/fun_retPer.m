function [HRpData,Lconf,Uconf,PlotData,yVarPlot,LconfPlot,UconfPlot,RpPlot]=fun_retPer(coef,Rp,result,confInt,stdH,r,v,...
    mulog,sigmalog,dataSorted,lambda,MonteCarloCons)
RpPlot=[0.001;1.00001;2;5;10;20;50;100;200;500;1000;2000;5000;10000;100000];
    if confInt==80
        confCoef=1.28;
    elseif confInt==90
        confCoef=1.645;
    elseif confInt==95
        confCoef=1.96;
    elseif confInt==98
        confCoef=2.33;
    elseif confInt==99
        confCoef=2.58;
    else
        error('Please enter a correct confidence interval such as 80,90,95,98,99%');
    end
   switch result
       case 1
            yVar=-log(-log(1-1./Rp./lambda));
            yVarPlot=-log(-log(1-1./RpPlot./lambda));
            HRpData=coef(1,1).*yVar+coef(1,2);
            PlotData=coef(1,1).*yVarPlot+coef(1,2);
            a1=0.64;
            a2=9.0;
            kapa=0.93;
            c=0;
            alfa=1.33;
            a=a1*exp(a2*(r^(-1.3))+kapa*(-log(v))^2);
            
            sigmaZ=sqrt(1+a.*((yVar-c+alfa.*log(v)).^2))./sqrt(r);
            sigmaVar=sigmaZ*stdH;
            Lconf=HRpData-confCoef*sigmaVar;
            Uconf=HRpData+confCoef*sigmaVar;
            
            sigmaZPlot=sqrt(1+a.*((yVarPlot-c+alfa.*log(v)).^2))./sqrt(r);
            sigmaVarPlot=sigmaZPlot*stdH;
            LconfPlot=PlotData-confCoef*sigmaVarPlot;
            UconfPlot=PlotData+confCoef*sigmaVarPlot;            
            
        case 2
            yVar=-log(-log(1-1./Rp./lambda));
            yVarPlot=-log(-log(1-1./RpPlot./lambda));
            HRpData=coef(2,1).*yVar+coef(2,2);
            PlotData=coef(2,1).*yVarPlot+coef(2,2);
            a1=0.64;
            a2=9.0;
            kapa=0.93;
            c=0;
            alfa=1.33;
            a=a1*exp(a2*(r^(-1.3))+kapa*(-log(v))^2);
            
            sigmaZ=sqrt(1+a.*((yVar-c+alfa.*log(v)).^2))./sqrt(r);
            sigmaVar=sigmaZ*stdH;
            Lconf=HRpData-confCoef*sigmaVar;
            Uconf=HRpData+confCoef*sigmaVar;
            
            sigmaZPlot=sqrt(1+a.*((yVarPlot-c+alfa.*log(v)).^2))./sqrt(r);
            sigmaVarPlot=sigmaZPlot*stdH;
            LconfPlot=PlotData-confCoef*sigmaVarPlot;
            UconfPlot=PlotData+confCoef*sigmaVarPlot; 
        case 3
            k=2.5;
            yVar=k.*(((-log(1-1./Rp./lambda)).^(-1/k))-1);
            yVarPlot=k.*(((-log(1-1./RpPlot./lambda)).^(-1/k))-1);
            HRpData=coef(3,1).*yVar+coef(3,2);
            PlotData=coef(3,1).*yVarPlot+coef(3,2);
            a1=1.27;
            a2=0.12;
            N0=23;
            kapa=0.24;
            v0=1.34;
            c=0.3;
            alfa=2.3;
            a=a1*exp(a2*(log(r*(v^0.5)/N0))^2-kapa*(log(v/v0)));
            
            sigmaZ=sqrt(1+a.*((yVar-c+alfa.*log(v)).^2))./sqrt(r);
            sigmaVar=sigmaZ*stdH;
            Lconf=HRpData-confCoef*sigmaVar;
            Uconf=HRpData+confCoef*sigmaVar;
            
            sigmaZPlot=sqrt(1+a.*((yVarPlot-c+alfa.*log(v)).^2))./sqrt(r);
            sigmaVarPlot=sigmaZPlot*stdH;
            LconfPlot=PlotData-confCoef*sigmaVarPlot;
            UconfPlot=PlotData+confCoef*sigmaVarPlot; 
        case 4
            k=3.33;
            yVar=k.*(((-log(1-1./Rp./lambda)).^(-1/k))-1);
            yVarPlot=k.*(((-log(1-1./RpPlot./lambda)).^(-1/k))-1);
            HRpData=coef(4,1).*yVar+coef(4,2);
            PlotData=coef(4,1).*yVarPlot+coef(4,2);
            a1=1.23;
            a2=0.09;
            N0=25;
            kapa=0.36;
            v0=0.66;
            c=0.2;
            alfa=1.9;
            a=a1*exp(a2*(log(r*(v^0.5)/N0))^2-kapa*(log(v/v0)));
            
            sigmaZ=sqrt(1+a.*((yVar-c+alfa.*log(v)).^2))./sqrt(r);
            sigmaVar=sigmaZ*stdH;
            Lconf=HRpData-confCoef*sigmaVar;
            Uconf=HRpData+confCoef*sigmaVar;
            
            sigmaZPlot=sqrt(1+a.*((yVarPlot-c+alfa.*log(v)).^2))./sqrt(r);
            sigmaVarPlot=sigmaZPlot*stdH;
            LconfPlot=PlotData-confCoef*sigmaVarPlot;
            UconfPlot=PlotData+confCoef*sigmaVarPlot; 
        case 5
            k=5;
            yVar=k.*(((-log(1-1./Rp./lambda)).^(-1/k))-1);
            yVarPlot=k.*(((-log(1-1./RpPlot./lambda)).^(-1/k))-1);
            HRpData=coef(5,1).*yVar+coef(5,2);
            PlotData=coef(5,1).*yVarPlot+coef(5,2);
            a1=1.34;
            a2=0.07;
            N0=35;
            kapa=0.41;
            v0=0.45;
            c=0.1;
            alfa=1.6;
            a=a1*exp(a2*(log(r*(v^0.5)/N0))^2-kapa*(log(v/v0)));
            
            sigmaZ=sqrt(1+a.*((yVar-c+alfa.*log(v)).^2))./sqrt(r);
            sigmaVar=sigmaZ*stdH;
            Lconf=HRpData-confCoef*sigmaVar;
            Uconf=HRpData+confCoef*sigmaVar;
            
            sigmaZPlot=sqrt(1+a.*((yVarPlot-c+alfa.*log(v)).^2))./sqrt(r);
            sigmaVarPlot=sigmaZPlot*stdH;
            LconfPlot=PlotData-confCoef*sigmaVarPlot;
            UconfPlot=PlotData+confCoef*sigmaVarPlot; 
        case 6
            k=10;
            yVar=k.*(((-log(1-1./Rp./lambda)).^(-1/k))-1);
            yVarPlot=k.*(((-log(1-1./RpPlot./lambda)).^(-1/k))-1);
            HRpData=coef(6,1).*yVar+coef(6,2);
            PlotData=coef(6,1).*yVarPlot+coef(6,2);
            a1=1.48;
            a2=0.06;
            N0=60;
            kapa=0.47;
            v0=0.34;
            c=0;
            alfa=1.4;
            a=a1*exp(a2*(log(r*(v^0.5)/N0))^2-kapa*(log(v/v0)));
            
            sigmaZ=sqrt(1+a.*((yVar-c+alfa.*log(v)).^2))./sqrt(r);
            sigmaVar=sigmaZ*stdH;
            Lconf=HRpData-confCoef*sigmaVar;
            Uconf=HRpData+confCoef*sigmaVar;
            
            sigmaZPlot=sqrt(1+a.*((yVarPlot-c+alfa.*log(v)).^2))./sqrt(r);
            sigmaVarPlot=sigmaZPlot*stdH;
            LconfPlot=PlotData-confCoef*sigmaVarPlot;
            UconfPlot=PlotData+confCoef*sigmaVarPlot; 
        case 7
            k=0.75;
            yVar=(log(Rp.*lambda)).^(1/k);
            yVarPlot=(log(RpPlot.*lambda)).^(1/k);
            HRpData=coef(7,1).*yVar+coef(7,2);
            PlotData=coef(7,1).*yVarPlot+coef(7,2);
            a1=1.65;
            a2=11.4;
            kapa=-0.63;
            c=0;
            alfa=1.15;
            a=a1*exp(a2*(r^(-1.3))+kapa*(-log(v))^2);
            
            sigmaZ=sqrt(1+a.*((yVar-c+alfa.*log(v)).^2))./sqrt(r);
            sigmaVar=sigmaZ*stdH;
            Lconf=HRpData-confCoef*sigmaVar;
            Uconf=HRpData+confCoef*sigmaVar;
            
            sigmaZPlot=sqrt(1+a.*((yVarPlot-c+alfa.*log(v)).^2))./sqrt(r);
            sigmaVarPlot=sigmaZPlot*stdH;
            LconfPlot=PlotData-confCoef*sigmaVarPlot;
            UconfPlot=PlotData+confCoef*sigmaVarPlot;            
        case 8
            k=1;
            yVar=(log(Rp.*lambda)).^(1/k);
            yVarPlot=(log(RpPlot.*lambda)).^(1/k);
            HRpData=coef(8,1).*yVar+coef(8,2);
            PlotData=coef(8,1).*yVarPlot+coef(8,2);
            a1=1.92;
            a2=11.4;
            kapa=0;
            c=0.3;
            alfa=0.9;
            a=a1*exp(a2*(r^(-1.3))+kapa*(-log(v))^2);
            
            sigmaZ=sqrt(1+a.*((yVar-c+alfa.*log(v)).^2))./sqrt(r);
            sigmaVar=sigmaZ*stdH;
            Lconf=HRpData-confCoef*sigmaVar;
            Uconf=HRpData+confCoef*sigmaVar;
            
            sigmaZPlot=sqrt(1+a.*((yVarPlot-c+alfa.*log(v)).^2))./sqrt(r);
            sigmaVarPlot=sigmaZPlot*stdH;
            LconfPlot=PlotData-confCoef*sigmaVarPlot;
            UconfPlot=PlotData+confCoef*sigmaVarPlot; 
        case 9
            k=1.4;
            yVar=(log(Rp.*lambda)).^(1/k);
            yVarPlot=(log(RpPlot.*lambda)).^(1/k);
            HRpData=coef(9,1).*yVar+coef(9,2);
            PlotData=coef(9,1).*yVarPlot+coef(9,2);
            a1=2.05;
            a2=11.4;
            kapa=0.69;
            c=0.4;
            alfa=0.72;
            a=a1*exp(a2*(r^(-1.3))+kapa*(-log(v))^2);
            
            sigmaZ=sqrt(1+a.*((yVar-c+alfa.*log(v)).^2))./sqrt(r);
            sigmaVar=sigmaZ*stdH;
            Lconf=HRpData-confCoef*sigmaVar;
            Uconf=HRpData+confCoef*sigmaVar;
            
            sigmaZPlot=sqrt(1+a.*((yVarPlot-c+alfa.*log(v)).^2))./sqrt(r);
            sigmaVarPlot=sigmaZPlot*stdH;
            LconfPlot=PlotData-confCoef*sigmaVarPlot;
            UconfPlot=PlotData+confCoef*sigmaVarPlot; 
        case 10
            k=2;
            yVar=(log(Rp.*lambda)).^(1/k);
            yVarPlot=(log(RpPlot.*lambda)).^(1/k);
            HRpData=coef(10,1).*yVar+coef(10,2);
            PlotData=coef(10,1).*yVarPlot+coef(10,2);
            a1=2.24;
            a2=11.4;
            kapa=1.34;
            c=0.5;
            alfa=0.54;
            a=a1*exp(a2*(r^(-1.3))+kapa*(-log(v))^2);
            
            sigmaZ=sqrt(1+a.*((yVar-c+alfa.*log(v)).^2))./sqrt(r);
            sigmaVar=sigmaZ*stdH;
            Lconf=HRpData-confCoef*sigmaVar;
            Uconf=HRpData+confCoef*sigmaVar;
           
            sigmaZPlot=sqrt(1+a.*((yVarPlot-c+alfa.*log(v)).^2))./sqrt(r);
            sigmaVarPlot=sigmaZPlot*stdH;
            LconfPlot=PlotData-confCoef*sigmaVarPlot;
            UconfPlot=PlotData+confCoef*sigmaVarPlot; 
       case 11
            [HRpData,Lconf,Uconf,PlotData,yVarPlot,LconfPlot,...
            UconfPlot]=fun_montecarlo_log(coef(11,1),coef(11,2),RpPlot,mulog,...
            sigmalog,Rp,dataSorted,confInt,lambda,MonteCarloCons);
            
    end
end



