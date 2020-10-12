function [c_ltwst,ltwst] = fun_ltws(data,int,fontSize,fontName,lang,divide)
%% Calculations

plot_hour=[8.76*10^-3,1,5,10,20,50,100,1000,2000,5000,8760];                % Enter plot hours
stDir=min(data(:,9));
endDir=max(data(:,9));
directionss=stDir:endDir;

if lang==1
    Direction=["N","NNE","NE","ENE","E","ESE","SE","SSE","S",...
        "SSW","SW","WSW","W","WNW","NW","NNW"];
    Div_Direction=["N","N","NNE","NNE","NE","NE","ENE","ENE","E","E","ESE",...
        "ESE","SE","SE","SSE","SSE","S","S","SSW","SSW","SW","SW","WSW",...
        "WSW","W","W","WNW","WNW","NW","NW","NNW","NNW"];
else
    Direction=["K","KKD","KD","DKD","D","DGD","GD","GGD","G",...
        "GGB","GB","BGB","B","BKB","KB","KKB"];
    Div_Direction=["K","K","KKD","KKD","KD","KD","DKD","DKD","D","D","DGD",...
        "DGD","GD","GD","GGD","GGD","G","G","GGB","GGB","GB","GB","BGB",...
        "BGB","B","B","BKB","BKB","KB","KB","KKB","KKB"];
end

k=1;
[nrows,~]=size(data);
H=0:int:(ceil(max(data(:,8))/int))*int;
rp=[1,5,10,20,50,100];
p=rp/24/365;
dim1=ceil(max(data(:,8))/int)+1;
dim2=16;
ltwst=zeros(dim1,dim2);

for i=1:nrows
    if data(i,8)==0
        continue
    end
    ltwst(ceil(data(i,8)/int),data(i,9))=...
        ltwst(ceil(data(i,8)/int),data(i,9))+1;
end

c_ltwst=cumsum(ltwst,'reverse');
t_hour=nrows;
p_ltwst=c_ltwst/t_hour;
ln_ltwst=log(p_ltwst); ln_ltwst(isinf(ln_ltwst))=0;
wind_clas=(0:int:((dim1-1)*int))';

for i=1:dim2
    c1=nonzeros(ln_ltwst(:,i));
    c2=wind_clas(1:numel(c1));
    [A(i),B(i),~]=postreg(c2,c1,'hide');
end

%% Ltws equations

curFold=dir;

if any(strcmp('outputs',{curFold.name}))
    cd outputs;
else
    mkdir outputs;
    cd outputs;
end

fid=fopen('ltws_equations.txt','w');
fprintf(fid,'Direction\t\t\t\tLTWS Equation\n');
wrt_format='\t%s\t\t\t%f*ln[Q(>Uave,10)]+(%f)\n';

for i=1:dim2
    fprintf(fid,wrt_format,Direction(i),A(i),B(i));
end

fclose(fid);

%% Ltws returnperiod values

fid=fopen('ltws_returnperiods.txt','w');
fprintf(fid,'\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tUave,10(m/s)\nHours\tN');
fprintf(fid,'\t\tNNE\t\tNE\t\tENE\t\tE\t\tESE\t\tSE\t\tSSE\t\tS\t\t');
fprintf(fid,'SSW\t\tSW\t\tWSW\t\tW\t\tWNW\t\tNW\t\tNNW\n');
wrt_format1='%3d\t\t';
wrt_format2='%.2f\t';

for i=1:numel(p)
    fprintf(fid,wrt_format1,rp(i));
    for j=1:dim2
        num=round(A(j)*log(p(i))+B(j),2);
        fprintf(fid,wrt_format2,num);
    end
    fprintf(fid,'\n');
end

fclose(fid);

%% Ltws plot

plot_p=plot_hour/365/24;
plot_x=log(plot_p);
if lang==2
    yName='\bf{U_{ave,10} (m/s)}';
    xName='\bf{Aþýlma Olasýlýðý, Q(>U_{ave,10})}';
    titleName='\bf{Aþýlan Süre (Saat)}';
elseif lang==1
    yName='\bf{U_{ave,10} (m/s)}';
    xName='\bf{Exceedance Probability, Q(>U_{ave,10}) }';
    titleName='\bf{Exceeded Hours}';
end
markers={'-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-'};
%markers={'-+','-o','-*','-x','-s','-d','-p','-h','-^','-v','->','-<','-.','-+','-o','-*'};
lineColors{1}=[0    0.4470    0.7410];
lineColors{2}=[0.8500    0.3250    0.0980];
lineColors{3}=[0.9290    0.6940    0.1250];
lineColors{4}=[0.4940    0.1840    0.5560];
lineColors{5}=[0.4660    0.6740    0.1880];
lineColors{6}=[0.3010    0.7450    0.9330];
lineColors{7}=[0.6350    0.0780    0.1840];
lineColors{8}=[255 102 178]./255;
lineColors{9}=[128 128 128 ]./255;
lineColors{10}=[141 239 105 ]./255;
lineColors{11}=[153 153 255 ]./255;
lineColors{12}=[255 51 51 ]./255;
lineColors{13}=[183 81 129 ]./255;
lineColors{14}=[0 0 0]./255;
lineColors{15}=[102 136 228]./255;
lineColors{16}=[204 153 255]./255;
vPlot=[1;5;10;20;50;100;1000;2000;5000];
vPlotProb=vPlot./(365*24);
[goto,~]=size(vPlotProb);

%% Divided Plots
if divide==1
    k=1;
    for i=1:numel(directionss)
        if A(i)==0
            continue
        elseif mod(k+2,3)==0
            jj=1;
            figure('units','normalized','outerposition',[0 0 1 1]);
            hold on
            plot_y(i,:)=A(i)*plot_x+B(i);
            h=semilogx(plot_p,plot_y(i,:),markers{i},'Color',lineColors{i},'LineWidth',1.2);
            set(h,'MarkerFaceColor',get(h,'Color'));
            scatter(p_ltwst(:,i),H,'MarkerEdgeColor',lineColors{i});
            set(gca, 'XScale','log','FontName','Calibri','FontSize',fontSize)
            set(gca, 'XScale','log','FontName','Calibri','FontSize',fontSize);
            xlabel(xName,'FontSize',fontSize);
            ylabel(yName,'FontSize',fontSize);
            gg=i;
            grid on;
            box on;
            legIndex(jj)=1+(2*(i-1));
            legIndex(jj+1)=1+(2*(i-1));
        else
            jj=jj+2;
            plot_y(i,:)=A(i)*plot_x+B(i);
            h=semilogx(plot_p,plot_y(i,:),markers{i},'Color',lineColors{i},'LineWidth',1.2);
            set(h,'MarkerFaceColor',get(h,'Color'));
            scatter(p_ltwst(:,i),H,'MarkerEdgeColor',lineColors{i});
            legIndex(jj)=1+(2*(i-1));
            legIndex(jj+1)=2+(2*(i-1));
        end
        if mod(k+2,3)==2 || i==numel(directionss)
            cann=Div_Direction(legIndex);
            gg2=i;
            handle=title(titleName,'FontSize',fontSize);
            set(handle,'Position',[10^-2,max(max(plot_y(gg:gg2,:)))+0.14*max(max(plot_y(gg:gg2,:)))]);
            ylim([0 max(max(plot_y(gg:gg2,:)))+0.1*max(max(plot_y(gg:gg2,:)))])
            
            for ii=1:goto % plotting vertical lines
                plot([vPlotProb(ii,1),vPlotProb(ii,1)],[min(ylim),max(ylim)+1],':','Color','k','LineWidth',1.2)
                txtName=sprintf('%s',num2str(vPlot(ii,1)));
                text(vPlotProb(ii,1),max(max(plot_y(gg:gg2,:)))+0.12*max(max(plot_y(gg:gg2,:))),txtName,'FontSize',fontSize,'FontName',fontName);
            end
            legend(cann);
            hold off
            clear legIndex
        end
        k=k+1;
    end
    
    %% Single Plot
else
    figure('units','normalized','outerposition',[0 0 1 1]);
    
    for i=1:dim2
        if A(i)==0
            continue
        else
            plot_y(i,:)=A(i)*plot_x+B(i);
            hold on
            h=semilogx(plot_p,plot_y(i,:),markers{i},'Color',lineColors{i},'LineWidth',1.2);
            set(h,'MarkerFaceColor',get(h,'Color'));
        end
    end
    index=find(A==0);
    Direction(index)=[];
    vPlot=[1;5;10;20;50;100;1000;2000;5000];
    vPlotProb=vPlot./(365*24);
    [goto,~]=size(vPlotProb);
    
    for i=1:goto % plotting vertical lines
        plot([vPlotProb(i,1),vPlotProb(i,1)],[min(ylim),max(ylim)+1],':','Color','k','LineWidth',1.2)
        txtName=sprintf('%s',num2str(vPlot(i,1)));
        text(vPlotProb(i,1),max(max(plot_y))+0.12*max(max(plot_y)),txtName,'FontSize',fontSize,'FontName',fontName);
    end
    
    legend(Direction);
    set(gca, 'XScale','log','FontName','Calibri','FontSize',fontSize);
    xlabel(xName,'FontSize',fontSize);
    ylabel(yName,'FontSize',fontSize);
    handle=title(titleName,'FontSize',fontSize);
    set(handle,'Position',[10^-2,max(max(plot_y))+0.14*max(max(plot_y))]);
    ylim([0 max(max(plot_y))+0.1*max(max(plot_y))])
    grid on;
    box on;
end

cd ..
end






