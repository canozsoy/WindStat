function [] = fun_hist(data,x_hist,fontSize,fontName,lang)
    [nrows,ncols]=size(data);
    years=data(1,1):data(nrows,1);
    nYears=numel(years);
    fig=figure('units','normalized','outerposition',[0 0 1 1]);
    set(fig,'defaultAxesColorOrder',[0 0 0;0 0 0])
    [counts,centers]=hist(data(:,8),x_hist);
    histogram(data(:,8),x_hist,'facecolor','b','Normalization','probability')
    xticks(x_hist)
    ytix=get(gca,'YTick');
    set(gca,'YTick',ytix,'YTickLabel',ytix*100);
    ax=gca; ax.YRuler.Exponent=0; ax.XRuler.Exponent=0;
    mt=max(ylim);
    grid on
    if lang==1
        ylabel('Frequency (%)');
        xlabel('Wind Class (m/s)');
        set(ax,'FontName',fontName,'FontSize',fontSize)
    else
        ylabel('Frekans (%)');
        xlabel('Rüzgar Sýnýfý (m/s)');
        set(ax,'FontName',fontName,'FontSize',fontSize)
        
end

