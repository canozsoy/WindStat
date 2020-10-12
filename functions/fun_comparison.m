function [result,distName1,distPoint1,distName2,distPoint2,...
    distName3,distPoint3,results,distPoint4]=fun_comparison(RSum,RsqrSum,mirSum,recSum,...
    zetaUp,zetaLow,zeta)
% DOL Criterion
points=zeros(11,1);
for i=1:11
    if zeta>zetaLow(i,1) && zeta<zetaUp(i,1)
        points(i,1)=10;
    end
end
%
% REC Criterion
for i=1:11
    if (1-RSum(i,1))<recSum(i,1)
        points(i,1)=points(i,1)+10;
    end
end
%
% MIR Criterion
mirDist=mirSum;
[~,mirSortIndex]=sort(mirDist,'ascend');
counter=10;
for i=1:11
    points(mirSortIndex(i,1),1)=points(mirSortIndex(i,1),1)+counter;
    counter=counter-1;
end
%
% R Order
[~,RSortIndex]=sort(RSum,'descend');
counter=10;
for i=1:11
    points(RSortIndex(i,1),1)=points(RSortIndex(i,1),1)+counter;
    counter=counter-1;
end
%
% % Rsqr Order
% [~,RSqrSortIndex]=sort(RsqrSum,'descend');
% counter=10;
% for i=1:10
%     points(RSqrSortIndex(i,1),1)=points(RSqrSortIndex(i,1),1)+counter;
%     counter=counter-1;
% end
% %
[sortedPoints,sorted]=sort(points,'descend');
result=sorted(1,1);
distPoint1=sortedPoints(1,1);
result2=sorted(2,1);
distPoint2=sortedPoints(2,1);
result3=sorted(3,1);
distPoint3=sortedPoints(3,1);
result4=1;%always gumbell
distPoint4=points(1,1);
results=[result,result2,result3,result4];
%
if result==1
    distName1='Old Gumbel';
elseif result==2
    distName1='New Gumbel';
elseif result==3
    distName1='FT2 k=2.5';
elseif result==4
    distName1='FT2 k=3.33';
elseif result==5
    distName1='FT2 k=5.0';
elseif result==6
    distName1='FT2 k=10.0';
elseif result==7
    distName1='Weibull k=0.75';
elseif result==8
    distName1='Weibull k=1.0';
elseif result==9
    distName1='Weibull k=1.4';
elseif result==10
    distName1='Weibull k=2.0';
elseif result==11
    distName1='Log-Normal';
end
%
if result2==1
    distName2='Old Gumbel';
elseif result2==2
    distName2='New Gumbel';
elseif result2==3
    distName2='FT2 k=2.5';
elseif result2==4
    distName2='FT2 k=3.33';
elseif result2==5
    distName2='FT2 k=5.0';
elseif result2==6
    distName2='FT2 k=10.0';
elseif result2==7
    distName2='Weibull k=0.75';
elseif result2==8
    distName2='Weibull k=1.0';
elseif result2==9
    distName2='Weibull k=1.4';
elseif result2==10
    distName2='Weibull k=2.0';
elseif result2==11
    distName2='Log-Normal';
end

%
%
if result3==1
    distName3='Old Gumbel';
elseif result3==2
    distName3='New Gumbel';
elseif result3==3
    distName3='FT2 k=2.5';
elseif result3==4
    distName3='FT2 k=3.33';
elseif result3==5
    distName3='FT2 k=5.0';
elseif result3==6
    distName3='FT2 k=10.0';
elseif result3==7
    distName3='Weibull k=0.75';
elseif result3==8
    distName3='Weibull k=1.0';
elseif result3==9
    distName3='Weibull k=1.4';
elseif result3==10
    distName3='Weibull k=2.0';
elseif result3==11
    distName3='Log-Normal';
end
%
end

    
    
    
    
    
    
    
    
    
    




