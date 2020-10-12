function []=fun_wstat_extws(data,v,confInt,Rp,compSelect,lang,yLim,yLimVal,fontName,fontSize,lineWidth,...
    vLineWidth,lineColor,vLineColor,scatterColor,saveFig,lambda,pot_treshold,MonteCarloCons)
% Following loaded file should be in the format of Year, H, T, Direction.
% Directions are represented as numbers. There are 16 direction. North is
% the number 1 and North-North-West is 16. The numbers are ascending clockwise.

DirNames=["N","NNE","NE","ENE","E","ESE","SE","SSE","S","SSW","SW","WSW","W","WNW","NW","NNW"];

% Basic Calculations: Sorting, average, stdev, zeta
[r,~]=size(data);     % r: length of H data
dataSorted=zeros(r,3);
[dataSorted(:,2),sortIndex]=sort(data(:,2),'descend');
dataSorted(:,1)=data(sortIndex,1);
dataSorted(:,3)=data(sortIndex,3);
aveH=mean(data(:,2)); % average of H data
stdH=std(data(:,2));  % stdev of H data
zeta = (dataSorted(1,2)-aveH)/stdH; % zeta for dol criterion calc.
%%  FT-I: Gumbel Distribution
% Old Gumbel
alphaOldGum=0;
betaOldGum=1;
[AOldGum,BOldGum,y1,ROldGum,RsqrOldGum,zetaUpGum,zetaLowGum]= fun_gumbel(dataSorted,alphaOldGum,betaOldGum,r,v); % Slope, intercept, R, Rsqr, zetaLow, zetaUp
%
% New Gumbel
alphaNewGum=0.44;
betaNewGum=0.12;
[ANewGum,BNewGum,y2,RNewGum,RsqrNewGum]= fun_gumbel(dataSorted,alphaNewGum,betaNewGum,r,v); % Slope, intercept, R, Rsqr, zetaLow, zetaUp
%
%%
%% FT-II for k1=2.5 k2=3.33 k3=5 k4=10
kFT2=[2.5;3.33;5;10];
AFT2=zeros(4,1);
BFT2=zeros(4,1);
RFT2=zeros(4,1);
RsqrFT2=zeros(4,1);
[AFT2(1,1),BFT2(1,1),y3,RFT2(1,1),RsqrFT2(1,1),zetaUpFT2(1,1),zetaLowFT2(1,1)]=fun_ft2(dataSorted,kFT2(1,1),r,v);
[AFT2(2,1),BFT2(2,1),y4,RFT2(2,1),RsqrFT2(2,1),zetaUpFT2(2,1),zetaLowFT2(2,1)]=fun_ft2(dataSorted,kFT2(2,1),r,v);
[AFT2(3,1),BFT2(3,1),y5,RFT2(3,1),RsqrFT2(3,1),zetaUpFT2(3,1),zetaLowFT2(3,1)]=fun_ft2(dataSorted,kFT2(3,1),r,v);
[AFT2(4,1),BFT2(4,1),y6,RFT2(4,1),RsqrFT2(4,1),zetaUpFT2(4,1),zetaLowFT2(4,1)]=fun_ft2(dataSorted,kFT2(4,1),r,v);
%%
%% WEIBULL for k1=0.75 k2=1 k3=1.4 k4=2
kW=[0.75;1;1.4;2];
AW=zeros(4,1);
BW=zeros(4,1);
RW=zeros(4,1);
RsqrW=zeros(4,1);
[AW(1,1),BW(1,1),y7,RW(1,1),RsqrW(1,1),zetaUpW(1,1),zetaLowW(1,1)]=fun_weibull(dataSorted,kW(1,1),r,v);
[AW(2,1),BW(2,1),y8,RW(2,1),RsqrW(2,1),zetaUpW(2,1),zetaLowW(2,1)]=fun_weibull(dataSorted,kW(2,1),r,v);
[AW(3,1),BW(3,1),y9,RW(3,1),RsqrW(3,1),zetaUpW(3,1),zetaLowW(3,1)]=fun_weibull(dataSorted,kW(3,1),r,v);
[AW(4,1),BW(4,1),y10,RW(4,1),RsqrW(4,1),zetaUpW(4,1),zetaLowW(4,1)]=fun_weibull(dataSorted,kW(4,1),r,v);
%%
%% LOGNORMAL
alfaLog=0.375;
betaLog=0.25;
[ALog,BLog,y11,RLog,RsqrLog,zetaUpLog,zetaLowLog,mulog,sigmalog]= fun_lognormal(dataSorted,alfaLog,betaLog,r,v);
%% MIR Criterion
[mirOldGum,mirNewGum,mirFT2,mirW,mirLog]=fun_mir(ROldGum,RNewGum,RFT2,RW,RLog,r,v);
%%
%% REC CRITERION
[recGum,recFT2,recW,recLog]=fun_rec(r,v);
%%
%% Comparison
% Old Gumbel:1, New Gumbel:2, FT2(k=2.5):3 ,FT2(k=3.33):4 ,FT2(k=5):5
% FT2(k=10):6, W(k=0.75):7, W(k=1):8, W(k=1.4):9, W(k=2):10, Lognormal:11
if compSelect==0
    RSum=[ROldGum;RNewGum;RFT2;RW;RLog];
    RsqrSum=[RsqrOldGum;RsqrNewGum;RsqrFT2;RsqrW;RsqrLog];
    mirSum=[mirOldGum;mirNewGum;mirFT2;mirW;mirLog];
    recSum=[recGum;recGum;recFT2;recW;recLog];
    zetaUp=[zetaUpGum;zetaUpGum;zetaUpFT2;zetaUpW;zetaUpLog];
    zetaLow=[zetaLowGum;zetaLowGum;zetaLowFT2;zetaLowW;zetaLowLog];
    [result,distName1,distPoint1,distName2,distPoint2,distName3,distPoint3,results,distPoint4]=fun_comparison(RSum,RsqrSum,mirSum,recSum,zetaUp,zetaLow,zeta);
    fprintf('BEST DISTRIBUTION IS %s with %f points! \n',distName1,distPoint1)
    fprintf('SECOND BEST DISTRIBUTION IS %s with %f points! \n',distName2,distPoint2)
    fprintf('THIRD BEST DISTRIBUTION IS %s with %f points! \n',distName3,distPoint3)
else
    result=compSelect;
    results=compSelect;
end
yAll=[y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11];
yBest=yAll(:,result);
%%
%% Compute Wave Heights and Wave Periods for given Return Periods with Conf. Intervals
coef=[AOldGum,BOldGum;ANewGum,BNewGum;AFT2,BFT2;AW,BW;ALog,BLog];
for i=1:numel(results)
    if i==1
        [HRpData,Lconf,Uconf,HPlotData,yVarPlot,LconfPlot,UconfPlot,RpPlot]=fun_retPer(coef,Rp,result,confInt,stdH,r,v,...
            mulog,sigmalog,dataSorted,lambda,MonteCarloCons);
    else
        [HRpData2(:,i)]=fun_retPer(coef,Rp,results(i),confInt,stdH,r,v,...
            mulog,sigmalog,dataSorted,lambda,MonteCarloCons);
    end
end
%TRpData=sqrt(HRpData./(steep*1.56));
%%
%% Plot the EXTWS Graph
if lang==2
    yName='\bf{R�zgar H�z�, U_{ave,10} (m/s)}';
    titleName='\bf{Yineleme Periyodu (Y�l)}';
    if result<=2
        xName='\bf{-ln[-ln(P(<U_{ave,10}))]}';
    elseif result>2 && result<=6
        xName='\bf{k\{[-ln(P(<U_{ave,10}))]^{-1/k}-1\}}';
    elseif result>6
        xName='\bf{[-ln(1-P(<U_{ave,10}))]^{1/k}}';
    end
elseif lang==1
    yName='\bf{Wind Velocity, U_{ave,10} (m/s)}';
    titleName='\bf{Return Period (Years)}';
    if result<=2
        xName='\bf{-ln[-ln(P(<U_{ave,10}))]}';
    elseif result>2 && result<=6
        xName='\bf{k\{[-ln(P(<U_{ave,10}))]^{-1/k}-1\}}';
    elseif result>6
        xName='\bf{[-ln(1-P(<U_{ave,10}))]^{1/k}}';
    end
end
if result==11
    xName='\bf{z}';
    figure('units','normalized','outerposition',[0 0 1 1])
    plot(yVarPlot,HPlotData,'Color',lineColor./255,'LineWidth',lineWidth) % plotting extws curve
    xlim([ceil(min(yVarPlot)+1),floor(max(yVarPlot)+1)])                                        % MANUALLY DEFINED
    hold on
    scatter(yBest,dataSorted(:,2),90,'filled','MarkerEdgeColor',scatterColor./255,'MarkerFaceColor',[1 1 1],'LineWidth',1.2); % plotting scatter data
    plot(yVarPlot,LconfPlot,'Color',scatterColor./255,'LineWidth',lineWidth) % plotting lower confidence interval
    plot(yVarPlot,UconfPlot,'Color',scatterColor./255,'LineWidth',lineWidth) % plotting upper confidence interval
    set(gca,'FontSize',fontSize);
    set(gca,'FontName',fontName);
    %set(gca,'YScale','log');                                                % To turn on logarithmic scale
    xlabel(xName,'FontSize',fontSize);
    ylabel(yName,'FontSize',fontSize);
    handle=title(titleName,'FontSize',fontSize);
    grid on
    grid minor
    if yLim==1
        yLimVal=[0;round(UconfPlot(end-1,1))];
    end
    ylim([yLimVal(1,1),yLimVal(2,1)]);
    [row,~]=size(yVarPlot);
    for i=2:row % plotting vertical lines
        plot([yVarPlot(i,1),yVarPlot(i,1)],[yLimVal(1,1),yLimVal(2,1)],':','Color',vLineColor./255,'LineWidth',vLineWidth)
        txtName=sprintf('%s',num2str(RpPlot(i,1)));
        set(text(yVarPlot(i,1)+0.06,yLimVal(2,1)-1.7,txtName,'FontSize',fontSize,'FontName',fontName),'Rotation',90);
    end
    set(handle,'Position',[yVarPlot(round((row-1)/2),1),yLimVal(2,1)]);
    set(gcf,'PaperPositionMode','auto')
    if saveFig==1
        print('extwsGraph','-dpng', '-r500');
    end
else
    figure('units','normalized','outerposition',[0 0 1 1])
    plot(yVarPlot,HPlotData,'Color',lineColor./255,'LineWidth',lineWidth) % plotting extws curve
    hold on
    scatter(yBest,dataSorted(:,2),90,'filled','MarkerEdgeColor',scatterColor./255,'MarkerFaceColor',[1 1 1],'LineWidth',1.2); % plotting scatter data
    plot(yVarPlot,LconfPlot,'Color',scatterColor./255,'LineWidth',lineWidth) % plotting lower confidence interval
    plot(yVarPlot,UconfPlot,'Color',scatterColor./255,'LineWidth',lineWidth) % plotting upper confidence interval
    set(gca,'FontSize',fontSize);
    set(gca,'FontName',fontName);
    xlabel(xName,'FontSize',fontSize);
    ylabel(yName,'FontSize',fontSize);
    handle=title(titleName,'FontSize',fontSize);
    grid on
    grid minor
    if yLim==1
        yLimVal=[0;round(UconfPlot(end,1)+UconfPlot(end,1)*0.1)];
    end
    ylim([yLimVal(1,1),yLimVal(2,1)]);
    [row,~]=size(yVarPlot);
    for i=2:row % plotting vertical lines
        plot([yVarPlot(i,1),yVarPlot(i,1)],[yLimVal(1,1),yLimVal(2,1)],':','Color',vLineColor./255,'LineWidth',vLineWidth)
        txtName=sprintf('%s',num2str(RpPlot(i,1)));
        text(yVarPlot(i,1),yLimVal(2,1)+0.012*yLimVal(2,1),txtName,'FontSize',fontSize,'FontName',fontName);
    end
    set(handle,'Position',[(abs(real(yVarPlot(1,1)))+yVarPlot(end,1))/2,yLimVal(2,1)+0.02*yLimVal(2,1)]);
    set(gcf,'PaperPositionMode','auto')
    if saveFig==1
        print('extwsGraph','-dpng', '-r500');
    end
end

%% Write Outputs

if compSelect~=0
    return
end

curFold=dir;

if any(strcmp('outputs',{curFold.name}))
    cd outputs;
else
    mkdir outputs;
    cd outputs;
end

fid=fopen('extws_nondirectional.txt','w');
fprintf(fid,'##### Non-Directional #####\n');
fprintf(fid,'Peak Over Treshold is %.2f m/s\n',pot_treshold);
fprintf(fid,'Best Distribution Is %s with %f points! \n',distName1,distPoint1);
fprintf(fid,'Second Best Distribution Is IS %s with %f points! \n',distName2,distPoint2);
fprintf(fid,'Third Best Distribution Is %s with %f points! \n',distName3,distPoint3);
fprintf(fid,'##############\n');
[row,col]=size(data);

for i=1:row
    for j=1:col
        if j==col
            fprintf(fid,'%s\t',DirNames(data(i,j)));
        else
        fprintf(fid,'%.2f\t',data(i,j));
        end
    end
    fprintf(fid,'\n');
end

fprintf(fid,'##############\n');
distName4='Old Gumbell';
distname={distName1,distName2,distName3,distName4};
distname=convertCharsToStrings(distname);
for j=1:numel(distname)
    if j==4
        fprintf(fid,'%s\t(with %d points!)\n',distname(j),distPoint4);
        fprintf(fid,'Return Period (years)\t\tStorm Avg. Wind Vel. (m/s)\n');
        for i=1:numel(Rp)
            fprintf(fid,'\t%6d\t\t\t\t\t\t\t%.2f\n',Rp(i),HRpData2(i,j));
        end
    else
        fprintf(fid,'%s\n',distname(j));
        fprintf(fid,'Return Period (years)\t\tStorm Avg. Wind Vel. (m/s)\n');
        if j==1
            for i=1:numel(Rp)
                fprintf(fid,'\t%6d\t\t\t\t\t\t\t%.2f\n',Rp(i),HRpData(i));
            end
        else
            for i=1:numel(Rp)
                fprintf(fid,'\t%6d\t\t\t\t\t\t\t%.2f\n',Rp(i),HRpData2(i,j));
            end
        end
    end
end

fclose(fid);
cd ..

end



