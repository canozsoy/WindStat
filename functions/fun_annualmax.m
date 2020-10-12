function []= fun_annualmax(data,v,confInt,Rp,compSelect,lang,...
    extwsYLim,extwsYLimVal,fontName,fontSize,extwsLineWidth,...
    extwsVLineWidth,extwsLineColor,extwsVLineColor,extwsScatterColor,extwsSaveFig,StAverage,MonteCarloCons)
%% Extws annual maxima method
% Non-Directional

k=1;
[row,col]=size(data);
pot_thres=0;
lambda=1;
if StAverage==1
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

for i=1:nyears
    k=1;
    for j=1:nrows
        if St_Data(j,2)==years(i)
            sep_Data(k,:,i)=St_Data(j,:);
            k=k+1;
        end
    end
end

for i=1:nyears
    nondir_res(i,1)=years(i);
    [value,idx]=max(sep_Data(:,3,i));
    nondir_res(i,2)=sep_Data(idx,3,i);
    nondir_res(i,3)=sep_Data(idx,1,i);
    nondir_res(i,4)=sep_Data(idx,4,i);
end

zeroIndices=find(nondir_res(:,2)==0);
nondir_res(zeroIndices,:)=[];

fun_wstat_extws(nondir_res,v,confInt,Rp,compSelect,lang,extwsYLim,...
    extwsYLimVal,fontName,fontSize,extwsLineWidth,...
    extwsVLineWidth,extwsLineColor,extwsVLineColor,...
    extwsScatterColor,extwsSaveFig,lambda,pot_thres,MonteCarloCons)
clear zeroIndices;
if compSelect~=0
    return
end
%% Extws for directional

[r1,c1,d1]=size(sep_Data);

for i=1:d1
    k=ones(dir,1);
    for j=1:r1
        if sep_Data(j,1,i)<=0
            break
        end
        dir_res_temp{sep_Data(j,4,i),i}(k(sep_Data(j,4,i),1),1:c1)=sep_Data(j,1:c1,i);
        k(sep_Data(j,4,i),1)=k(sep_Data(j,4,i),1)+1;
    end
end

[rsep,~]=size(dir_res_temp);
k=1;

for i=1:rsep
    for j=1:nyears
        if isempty(dir_res_temp{i,j})
            index(k)=i;
            k=k+1;
            break
        elseif j==nyears
            index(k)=9999;
            k=k+1;
        end
    end
end

for i=1:nyears
    for j=1:dir
        if isempty(dir_res_temp{j,i})
            dir_res_temp{j,i}=zeros(1,2);
            index2=1;
        else
            [value,index2]=max(dir_res_temp{j,i}(:,3));
            dir_res(j,i,1)=value;
            dir_res(j,i,2)=dir_res_temp{j,i}(index2,1);
        end
    end
end


for i=1:dir
    if any(i==index)
        continue
    end
    output(:,1)=years(1):years(end);
    output(:,2)=dir_res(i,:,1)';
    output(:,3)=dir_res(i,:,2)';
    output(:,4)=i;
    zeroIndices=find(output(:,2)==0);
    output(zeroIndices,:)=[];
    fun_wstat_extws_noPlot(output,v,confInt,Rp,compSelect,i,lambda,pot_thres,MonteCarloCons);
    clear output zeroIndices;
end
end
