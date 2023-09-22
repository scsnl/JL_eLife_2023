function line_averge_twogroup(group1_data,group2_data,group1_color,group2_color, Ylim_range, Xticklabel, pic_title,y_label, output_path)
% Data sould be a matrix (M * N), where N is the number of runs and M is the
% number of subjects

b=plot(mean(group2_data),'-o','Color',group2_color,'LineWidth',4,'MarkerSize',10);
hold on
% plot(mean(group1_data)','-o','Color',group1_color,'LineWidth',3)
a=plot(mean(group1_data)','-o','Color',group1_color,'LineWidth',4,'MarkerSize',10);

group1_se=std(group1_data)/sqrt(length(group1_data));
group2_se=std(group2_data)/sqrt(length(group2_data));
 x = [1:1:size(group1_data,2)];
errorbar(x,mean(group2_data)',group2_se,'o','color',group2_color,'linewidth',3);
errorbar(x,mean(group1_data)',group1_se,'o','color',group1_color,'linewidth',3);

set(gca,'YLim',Ylim_range);
set(gca,'ytick',[0:5:10])
set(gca, 'YTickLabel' ,[0:5:10])
set(gca,'XLim',[0.7 5.3]);
set(gca,'FontSize',25);
set(gca,'LineWidth',4);
set(gca,'xtick',x)
set(gca, 'XTickLabel',Xticklabel)
title(pic_title)
ylabel(y_label)
legend('ASD','TD','Location','NorthEastOutside')  
set(gcf,'position',[150,150,580,390]) ;  
print(gcf,'-dtiff',output_path);
% close all
end
