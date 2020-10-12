%{ 
This code calculates wind statistics and writes outputs.
Prepared by C.Özsoy (2019) - extreme statistics are taken from H.G.Güler et al (2017).
version 1.01
%}

clc
clear
close all
tic

%% Inputs

dataType=1;                                                                 % Enter datatype. (1):ERA5 (single files also datatype 1), (2):CFSR
dataName='input.mat';                                                     % Enter data name for ERA5
dataName1='uv_cfsr.mat';                                                    % Enter data name for CFSR
dataName2='uv_cfsr_v2.mat';                                                 % Enter data name for CFSR
hist=1;                                                                     % (1): Plots histogram; (2): Do not plot histogram;
ltws=1;                                                                     % (1): Opens long term wind stat.; (0):Closes
extws=1;                                                                    % (1): Opens extreme term wind stat.; (0): Closes
StAverage=0;                                                                % (1): Storm Averaged; (0): Hourly Averaged (raw)
pot=1;                                                                      % (1): Opens peak over treshold; (0): closes
fontSize=25;                                                                % Define font size
fontName='Calibri';                                                         % Define font name
lang=1;                                                                     % Select language of plots 1:English, 2:Turkish
MonteCarloCons=0.04;                                                        % Constant for the confidence intervals in monte-carlo simulation, % Goda(0.04-0.08)It might be changed to (0.04-0.1) 

% For other options below should be checked!!

%% Data Load -Do not change

addpath('functions');

cd inputs
if dataType==1
    temp = load(dataName); fName = fieldnames(temp); varName = fName{1};
    data = getfield(temp, varName); 
    cd ..
%     load(dataName); data=corData; clear corData;
%     cd ..
elseif dataType==2
    temp1 = load(dataName1); fName1 = fielnames(temp1); varName1 = fName1{1};
    data1 = getfield(temp1, varName1);
    temp2 = load(dataName2); fName2 = fielnames(temp2); varName2 = fName2{1};
    data2 = getfield(temp2, varName2);
%     load(dataName1); data1=data; clear data; load(dataName2); data2=data; clear data;
    data=vertcat(data1,data2);
    cd ..
end

%% Histogram -Options

if hist==1
    int=0.5;                                                                % Select grouping interval for histogram
    x_hist=0:int:12;                                                        % Define histogram edges
    fun_hist(data,x_hist,fontSize,fontName,lang)
end

%% Long Term Wind Statistics -Options

if ltws==1
    divide=0;                                                               % divide ltws and give original values with fitted curves
    int=2;                                                                  % Select grouping interval for ltws
    fun_ltws(data,int,fontSize,fontName,lang,divide);
end
    
%% Extreme Wind Statistics -Options

if extws==1
    pot_thres=0;                                                            % If auto_pot is closed define pot threshold
    auto_pot=1;                                                             % 1:auto peakoverthreshold threshold 0:manual
    upperPotValue=60;                                                       % Upper limit value for pot (60 recommended)
    lowerPotValue=40;                                                       % Lower limit value for pot (40 recommended)
    v=1;
    Rp=[5;10;20;50;100;200;500;1000;2000;5000;10000];                       % Return periods
    confInt=90;                                                             % Confidence interval
    compSelect=0;                                                           % Select computation methodology. //0: best, Old Gumbel:1, New Gumbel:2,FT2(k=2.5):3,
                                                                            % FT2(k=3.33):4 ,FT2(k=5):5, FT2(k=10):6, W(k=0.75):7, W(k=1):8, W(k=1.4):9, W(k=2):10
                                                                            % Lognormal:11 (Note that it won't give results only plots except 0)
    fun_extws(data,v,pot,auto_pot,pot_thres,confInt,Rp,compSelect,lang,...
        fontName,fontSize,StAverage,upperPotValue,lowerPotValue,MonteCarloCons);
end

toc



