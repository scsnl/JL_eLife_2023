function bar_mean_group_strategy(table,Ylim_range,YTick,YTickLabel, XTicklabel, y_label,pic_title, output_path)

 h=bar(table);
 h(1).FaceColor = [173/255,181/255,189/255];
 h(2).FaceColor = [248/255,249/255,250/255];
box off
set(gca,'YLim',Ylim_range);
set(gca, 'YTick', YTick);
set(gca, 'YTickLabel', YTickLabel);
set(gca,'XLim',[0.5 2.8]);
set(gca,'FontSize',24);
set(gca,'LineWidth',4);
set(gca, 'XTick', [1 2]);
set(gca, 'XTickLabel' ,XTicklabel);
h(1).LineWidth = 3;
h(2).LineWidth = 3;

title(pic_title);
ylabel(y_label);
legend('Memory-based','Procedure-based','Location','southoutside')  
set(gcf,'position',[150,150,350,350]) ; 
print(gcf,'-dtiff',output_path);
close all
end

