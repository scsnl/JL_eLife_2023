function bar_time(type1,type2,colormap_beg,colormap_end,Ylim_range,YTick,YTickLabel, XTicklabel, pic_title,y_label, output_path,rank_direction)

data_mean=[mean(type1) mean(type2)];

% pics for dis
c1=bar([1],data_mean(1),'LineWidth',4,'BarWidth',0.5,'FaceColor','none','EdgeColor',colormap_beg./255); 
hold on
c2=bar([2],data_mean(2),'LineWidth',4,'BarWidth',0.5,'FaceColor','none','EdgeColor',colormap_end./255); 

% colormap_beg=[249, 251, 20];
% colormap_end=[62, 38, 168];
num_sub=length(type1);
colormap=[colormap_beg(1):-(abs(colormap_end(1)-colormap_beg(1))/(num_sub-1)):colormap_end(1);
    colormap_beg(2):-(abs(colormap_end(2)-colormap_beg(2))/(num_sub-1)):colormap_end(2);
    colormap_beg(3):-(abs(colormap_end(3)-colormap_beg(3))/(num_sub-1)):colormap_end(3)];

[~,ind_rank]=sort(type2-type1,rank_direction);
data= [type1(ind_rank) type2(ind_rank)]';

for i=1:num_sub
   plot(data(:,i)','-o','MarkerSize',12,'MarkerFaceColor',[colormap(:,i)./255]','LineWidth',2,'Color',[colormap(:,i)./255]'); 
end

box off
set(gca,'YLim',Ylim_range);
set(gca, 'YTick', YTick);
set(gca, 'YTickLabel', YTickLabel);
set(gca,'XLim',[0.5 2.5]);
set(gca,'FontSize',24);
set(gca,'LineWidth',4);
set(gca, 'XTick', [1 2]);
set(gca, 'XTickLabel' ,XTicklabel);

title(pic_title);
ylabel(y_label);
set(gcf,'position',[150,150,250,250]) ;  
print(gcf,'-dtiff',output_path);
% close all
end