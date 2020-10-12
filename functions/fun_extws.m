function [] = fun_extws(data,v,pot,auto_pot,pot_thres,confInt,Rp,compSelect,lang,...
    fontName,fontSize,StAverage,upperPotValue,lowerPotValue,MonteCarloCons)
%% Options
extwsYLim=1;                                                                % Limits of y-axis // 1: Auto, 2: Manual (change extwsYLimVal)
extwsYLimVal=[0;13];                                                        % Limits of y-axis if extwsYLim=2
extwsLineWidth=2;                                                           % Line width (extws curve)
extwsVLineWidth=1.5;                                                        % Line width (vertical lines)
extwsLineColor=[215,85,25];                                                 % Color (extws curve) as R G B
extwsVLineColor=[0,115,190];                                                % Color (vertical lines) as R G B
extwsScatterColor=[5,70,140];                                               % Scatter Color (extws curve) as R G B
extwsSaveFig=0;                                                             % 1: save the figure, 0: do not save the figure

if pot==1
    fun_pot(data,auto_pot,pot_thres,confInt,Rp,compSelect,lang,extwsYLim,...
        extwsYLimVal,fontName,fontSize,extwsLineWidth,...
        extwsVLineWidth,extwsLineColor,extwsVLineColor,...
        extwsScatterColor,extwsSaveFig,StAverage,upperPotValue,lowerPotValue,MonteCarloCons);
elseif pot==0
    fun_annualmax(data,v,confInt,Rp,compSelect,lang,...
        extwsYLim,extwsYLimVal,fontName,fontSize,extwsLineWidth,...
        extwsVLineWidth,extwsLineColor,extwsVLineColor,extwsScatterColor,extwsSaveFig,StAverage,MonteCarloCons);
end

