clear,clc
%% set the file path
box_path = 'pwd';    
addpath('figure code');

%% plot RRB on ACC-NRP
load('moderation_RRB_ACC_NRP.mat');
data=data_moderation_NRP;
% plot MTL
x1 = data(data(:,3)<10,5)% MTL
y1 = data(data(:,3)<10,4) % learning gains
x2 = data(data(:,3)>=10,5) % MTL 
y2 = data(data(:,3)>=10,4) % learning gains
[r1 p1]=corr(x1,y1)
[r2 p2]=corr(x2,y2)
output_name=fullfile(box_path,'results','Behavior','figures',['corr_RRIBsub1_prepostRSA_LparaHipp_Acc_moderation.tiff']);
beh_corr_scatter_group_mod(x1,y1,x2,y2,'NRP',['low RRB: r = ' num2str(r1,3) ' p = ' num2str(p1,3)],['high RRB: r = ' num2str(r2,3) ' p = ' num2str(p2,3)],'Learning gain','moderation (R MTL)',output_name)

% plot IPS
x1 = data(data(:,3)<10,6) % IPS
y1 = data(data(:,3)<10,4) % learning gains
x2 = data(data(:,3)>=10,6) % IPS
y2 = data(data(:,3)>=10,4) % learning gains
[r1 p1]=corr(x1,y1)
[r2 p2]=corr(x2,y2)
output_name=fullfile(box_path,'results','Behavior','figures',['corr_RRIBsub1_prepostRSA_RIPS_Acc_moderation.tiff']);
beh_corr_scatter_group_mod(x1,y1,x2,y2,'NRP',['low RRB: r = ' num2str(r1,3) ' p = ' num2str(p1,3)],['high RRB: r = ' num2str(r2,3) ' p = ' num2str(p2,3)],'Learning gain','moderation (L IPS)',output_name)
