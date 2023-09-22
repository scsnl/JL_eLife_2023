function beh_corr_scatter_group_mod(x1,y1,x2,y2,Xlabel1,Xlabel2,Xlabel3,Ylabel,pic_title,output_path)

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

dotcolor = [25/255, 25/255, 112/255];
shadecolor = [25/255, 25/255, 112/255];

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


%  [p1] = polyfit(x1,y1,1);
%   f1 = polyval(p1,x1); 
% plot(x1,f1,'-','LineWidth',4,'Color',[157/255,211/255,250/255]) 
% hold on
% [p1] = polyfit(x2,y2,1);
%   f2 = polyval(p1,x2); 
% % plot(x2,f2,'b-','LineWidth',4,'Color',[238/255 238/255 28/255]) 
% plot(x2,f2,'b-','LineWidth',4,'Color',[25/255, 25/255, 112/255]) 
% set(gca,'FontSize',22);
% set(gca,'LineWidth',4);
% 
% plot(x1,y1,'.','MarkerEdgeColor',[157/255,211/255,250/255],'MarkerSize',35)
% % plot(x2,y2,'.','MarkerEdgeColor',[238/255 238/255 28/255],'MarkerSize',35)
% plot(x2,y2,'.','MarkerEdgeColor',[25/255, 25/255, 112/255],'MarkerSize',35)

box on
set(gca,'FontSize',18);
set(gca,'LineWidth',4);

d1=(max([x1;x2])-min([x1;x2]))/5;
set(gca,'XLim',[min([x1;x2])-d1 max([x1;x2])+d1]);
d2=(max([y1;y2])-min([y1;y2]))/5;
set(gca,'YLim',[min([y1;y2])-d2 max([y1;y2])+d2]);

set(gca, 'XTick', [-1.5:0.5:0.5]);
set(gca, 'XTickLabel', [-1.5:0.5:0.5]);
set(gca, 'YTick', [-0.2:0.2:0.6]);
set(gca, 'YTickLabel', [-0.2:0.2:0.6]);

% set(gca, 'XTickLabel' ,{'Day1','Day2','Day3','Day4','Day5'})
ylabel(Ylabel)
xlabel({Xlabel1;Xlabel2;Xlabel3})
title(pic_title)
hold off
legend off
% legend([h1(2);h2(2)],'low IS','high IS','Location','NorthEastOutside')  
legend([h1(2);h2(2)],'transition','non-transition','Location','NorthEastOutside')  
set(gcf,'position',[50,50,550,450])   
% print(gcf,'-djpeg',output_path);
print(gcf,'-dtiff',output_path);
close all
end