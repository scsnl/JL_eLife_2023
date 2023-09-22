function beh_corr_scatter_2group(x1,y1,x2,y2,Xlabel1,Xlabel2,Xlabel3,Ylabel,pic_title,output_path)
%  [p1] = polyfit(x1,y1,1);

dotcolor = [157/255,211/255,250/255];
shadecolor = [72/255,91/255,161/255];

[xData, yData] = prepareCurveData(x1, y1);
ft = fittype( 'poly1' );
opts = fitoptions( ft );
opts.Lower = [-Inf -Inf];
opts.Upper = [Inf Inf];
[fitresult, gof] = fit( xData, yData, ft, opts );
hold on
xFit = linspace(min(xData),max(xData),100);
yPredict = predint(fitresult,xFit,0.95,'functional','off');
fy = cat(2,yPredict(:,2)',flip(yPredict(:,1),1)')';
fx  = cat(2,xFit,flip(xFit',1)')';
fill(fx,fy,shadecolor,'EdgeAlpha',0,'FaceAlpha',0.1);
h1=plot( fitresult, xData, yData);
set(h1(1),'Marker','.','MarkerSize',35,'Color',dotcolor)
set(h1(2),'LineWidth',4,'Color',dotcolor)

dotcolor = [255/255 166/255 158/255];
shadecolor = [199/255 92/255 88/255];

[xData, yData] = prepareCurveData(x2, y2);
ft = fittype( 'poly1' );
opts = fitoptions( ft );
opts.Lower = [-Inf -Inf];
opts.Upper = [Inf Inf];
[fitresult, gof] = fit( xData, yData, ft, opts );
hold on
xFit = linspace(min(xData),max(xData),100);
yPredict = predint(fitresult,xFit,0.95,'functional','off');
fy = cat(2,yPredict(:,2)',flip(yPredict(:,1),1)')';
fx  = cat(2,xFit,flip(xFit',1)')';
fill(fx,fy,shadecolor,'EdgeAlpha',0,'FaceAlpha',0.1);
h2=plot( fitresult, xData, yData);
set(h2(1),'Marker','.','MarkerSize',35,'Color',dotcolor)
set(h2(2),'LineWidth',4,'Color',dotcolor)

box on
set(gca,'FontSize',18);
set(gca,'LineWidth',4);

d1=(max([x1;x2])-min([x1;x2]))/5;
set(gca,'XLim',[min([x1;x2])-d1 max([x1;x2])+d1]);
d2=(max([y1;y2])-min([y1;y2]))/5;
set(gca,'YLim',[min([y1;y2])-d2 max([y1;y2])+d2]);

ylabel(Ylabel)
xlabel({Xlabel1;Xlabel2;Xlabel3})
hold off
legend off

title(pic_title)
legend([h1(2);h2(2)],'ASD','TD','Location','NorthEastOutside')  
set(gcf,'position',[50,50,500,400])   
print(gcf,'-djpeg',output_path);
% print(gcf,'-dtiff',output_path);
close all
end