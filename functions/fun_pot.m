function [] = fun_pot(data,auto_pot,pot_thres,confInt,Rp,compSelect,...
    lang,extwsYLim,extwsYLimVal,fontName,fontSize,extwsLineWidth,...
    extwsVLineWidth,extwsLineColor,extwsVLineColor,extwsScatterColor,...
    extwsSaveFig,StAverage,upperPotValue,lowerPotValue,MonteCarloCons)
% Peak Over Threshold Method
%% Non-Directional
potIncrement=0.1;
k=1;
[row,~]=size(data);
years=data(1,1):data(row,1);

for i=1:row
    if i==1 && data(i,8)>=3
        St_Info(k,1)=i;
    elseif i==1 && data(i,8)<3
        continue
    elseif data(i,8)>=3 && data(i-1,8)<3
        St_Info(k,1)=i;
    elseif data(i-1,8)>=3 && data(i,8)<3
        St_Info(k,2)=i-1;
        k=k+1;
    elseif i==row && data(i,8)>=3
        St_Info(k,2)=i;
    end
end

[row2,col2]=size(St_Info);

if StAverage==1
    for i=1:row2
        St_Data(i,1)=St_Info(i,2)-St_Info(i,1)+1;
        St_Data(i,2)=data(round((St_Info(i,1)+St_Info(i,2))/2),1);
        St_Data(i,3)=mean(data(St_Info(i,1):St_Info(i,2),8));
        St_Data(i,4)=mode(data(St_Info(i,1):St_Info(i,2),9));
    end
    
    delIndices=find(St_Data(:,1)<3);
    St_Data(delIndices,:)=[];
else
    St_Data(:,2)=data(:,1);
    St_Data(:,1)=1;
    St_Data(:,3)=data(:,8);
    St_Data(:,4)=data(:,9);
end

[nrows,ncols]=size(St_Data);
years=St_Data(1,2):St_Data(nrows,2);
nyears=numel(years);
directions=min(St_Data(:,4)):max(St_Data(:,4));
dir=numel(directions);
pointer=0;
pot_treshold=0;

if auto_pot==1
    while pointer==0
        temp=St_Data(:,3);
        temp(temp<pot_treshold)=0;
        [pks,locs]=findpeaks(temp);
        [r1,c1]=size(pks);
        if r1<=upperPotValue && r1>=lowerPotValue
            pointer=1;
        else
            pot_treshold=pot_treshold+potIncrement;
            pointer=0;
        end
    end
elseif auto_pot==0
    pot_treshold=pot_thres;
    temp=St_Data(:,3);
    temp(temp<pot_treshold)=0;
    [pks,locs]=findpeaks(temp);
    [r1,~]=size(pks);
end

for i=1:r1
    nondir_res(i,1)=St_Data(locs(i),2);
    nondir_res(i,2)=St_Data(locs(i),3);
    nondir_res(i,3)=St_Data(locs(i),1);
    nondir_res(i,4)=St_Data(locs(i),4);
end

if StAverage==0
    counter=0;                                                                % since it is storm averaged, nu will be 1!
    for i=1:numel(locs)
        for j=1:numel(St_Info(:,1))
            if locs(i)>=St_Info(j,1) && locs(i)<=St_Info(j,2)
                counter=counter+1;
            end
        end
    end
    nondir_nu=counter/numel(locs);
else
    nondir_nu=1;
end

[r2,~]=size(nondir_res);
nondir_lambda=r2/numel(years);


fun_wstat_extws(nondir_res,nondir_nu,confInt,Rp,compSelect,lang,extwsYLim,...
    extwsYLimVal,fontName,fontSize,extwsLineWidth,extwsVLineWidth,...
    extwsLineColor,extwsVLineColor,extwsScatterColor,extwsSaveFig,...
    nondir_lambda,pot_treshold,MonteCarloCons)
if compSelect~=0
    return
end
%% Directional

k=ones(dir,1);

for i=1:nrows
    for j=1:dir
        if St_Data(i,4)==j
            sep_StData{j,1}(k(j,1),1)=St_Data(i,2);
            sep_StData{j,1}(k(j,1),2)=St_Data(i,3);
            sep_StData{j,1}(k(j,1),3)=St_Data(i,1);
            sep_StData{j,1}(k(j,1),4)=St_Data(i,4);
            k(j,1)=k(j,1)+1;
        end
    end
end

[rsep,~]=size(sep_StData);
k=1;

for i=1:rsep
    if isempty(sep_StData{i,1})
        index(k)=i;
        k=k+1;
    else
        index(k)=9999;
        k=k+1;
    end
end

for i=1:dir
    if any(i==index)
        continue
    end
    dir_temp=sep_StData{i,1};
    pot_treshold=0;
    pointer=0;
    [rlst,~]=size(dir_temp);
    
    k=1;
    for iiii=1:rlst
        if iiii==1 && dir_temp(iiii,2)>=3
            sep_St_Info(k,1)=iiii;
        elseif iiii==1 && dir_temp(iiii,2)<3
            continue
        elseif dir_temp(iiii,2)>=3 && dir_temp(iiii-1,2)<3
            sep_St_Info(k,1)=iiii;
        elseif dir_temp(iiii-1,2)>=3 && dir_temp(iiii,2)<3
            sep_St_Info(k,2)=iiii-1;
            k=k+1;
        end
        if iiii==row
            sep_St_Info(k,2)=iiii;
        end
    end
    
    if auto_pot==1
        while pointer==0
            temp=dir_temp(:,2);
            temp(temp<pot_treshold)=0;
            [pks,locs]=findpeaks(temp);
            [r1,~]=size(pks);
            if pot_treshold==0 && r1<lowerPotValue
                pointer=1;
                continue
            end
            if r1<=upperPotValue && r1>=lowerPotValue
                pointer=1;
            else
                pot_treshold=pot_treshold+potIncrement;
                pointer=0;
            end
        end
    elseif auto_pot==0
        pot_treshold=pot_thres;
        temp=dir_temp(:,2);
        temp(temp<pot_treshold)=0;
        [pks,locs]=findpeaks(temp);
        [r1,~]=size(pks);
    end
    
    for ii=1:r1
        dir_res{i,1}(ii,1)=sep_StData{i,1}(locs(ii),1);
        dir_res{i,1}(ii,2)=sep_StData{i,1}(locs(ii),2);
        dir_res{i,1}(ii,3)=sep_StData{i,1}(locs(ii),3);
        dir_res{i,1}(ii,4)=sep_StData{i,1}(locs(ii),4);
    end
    
    dir_lambda=r1/numel(years);
    
    if StAverage==0
        counter=0;                                                                % since it is storm averaged, nu will be 1!
        for iii=1:numel(locs)
            for j=1:numel(sep_St_Info(:,1))
                if locs(iii)>=sep_St_Info(j,1) && locs(iii)<=sep_St_Info(j,2)
                    counter=counter+1;
                end
            end
        end
        dir_nu(i)=counter/numel(locs);
    else
        dir_nu(i)=1;
    end
    
    fun_wstat_extws_noPlot(dir_res{i,1},dir_nu(i),confInt,Rp,compSelect,i,...
        dir_lambda,pot_treshold,MonteCarloCons)
    if i==16
    else
        clear dir_temp pks locs sep_St_Info
    end
end
end






