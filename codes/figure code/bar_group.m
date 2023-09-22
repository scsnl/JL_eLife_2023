function bar_group(group1,group2,Ylim_range,YTick,YTickLabel, XTicklabel, y_label, output_path)

 Y{1}=group1;
 Y{2}=group2;
%  [h ,l]=violin(Y,'facecolor', [157/255,211/255,250/255;238/255 238/255 28/255],'medc','','facealpha',1,'plotlegend',0);
   [h ,l]=violin(Y,'facecolor', [157/255,211/255,250/255;255/255 166/255 158/255],'medc','','facealpha',1,'plotlegend',0);
box off
set(gca,'YLim',Ylim_range);
set(gca, 'YTick', YTick);
set(gca, 'YTickLabel', YTickLabel);
set(gca,'XLim',[0.5 2.8]);
set(gca,'FontSize',24);
set(gca,'LineWidth',4);
set(gca, 'XTick', [1 2]);
set(gca, 'XTickLabel' ,XTicklabel);

% title(pic_title);
ylabel(y_label);
set(gcf,'position',[150,150,500,400]) ;  
print(gcf,'-dtiff',output_path);
close all
end