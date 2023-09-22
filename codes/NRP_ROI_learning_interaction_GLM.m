clear,clc
%% set the file path
addpath('DPABI_V4.2_190919');
box_path = 'pwd';
oak_path = fullfile('2019_ASD_MathWhiz');

%% features from ANOVA on activation
load('Image_sublist_pre_post.mat');
Image_ASD_sublist=Image_sublist(Image_sublist(:,5)==1,:);
Image_TD_sublist=Image_sublist(Image_sublist(:,5)==2,:);
contrast = {'trained-rest';'untrained-rest'};
k=1;% set to 2 for untrained results for SI

[com_sub,IA,IB] = intersect(Image_sublist(:,1),[Image_ASD_sublist(:,1);Image_TD_sublist(:,1)]);
BPI_features=[];
data_path = fullfile(oak_path,'results','taskfmri','groupstats','rsa','NRD_ROI',contrast{k},'NRD_ROIs_ASD.mat');
load(data_path);
data_path = fullfile(oak_path,'results','taskfmri','groupstats','rsa','NRD_ROI',contrast{k},'NRD_ROIs_TD.mat');
load(data_path);

tmp_all=[ASD_NRD;TD_NRD];
BPI_features=[tmp_all(IB,:)];
ROI_input = {'IPS_L','IPS_R','MTL_L','MTL_R'}

%% pics for group differences in ROI signal 
for i=1:length(ROI_input)
    [h,p(i),ci,stats] = ttest2(ASD_NRD(:,i),TD_NRD(:,i));
    t(i)=stats.tstat;
    df(i)=stats.df;
    output_path = fullfile(box_path,'results','Behavior','figures',['ROI_' ROI_input{i} '_ASD_TD.tiff']);
    bar_group_small(ASD_NRD(:,i),TD_NRD(:,i),[-3 1.5],[-3 -1 1],[-3 -1 1], {'ASD','TD'}, 'NRP', output_path)
end

%% learning gain - scan task
load('taskscan_change_ACC.mat')
beh_feature=scantask_change_ACC;
for region_ind=1:size(BPI_features,2)
    if k==1
        [com_sub,IA,IB] = intersect(beh_feature(:,1),Image_sublist(:,1));
        Subjects_Scores = beh_feature(IA,3)./beh_feature(IA,5);
        Group_ind = Image_sublist(IB,5);
        all_feature = [Group_ind BPI_features(IB,region_ind) Group_ind.*BPI_features(IB,region_ind)];
    elseif k==2
        [com_sub,IA,IB] = intersect(beh_feature(:,1),Image_sublist(:,1));
        Subjects_Scores = beh_feature(IA,4)./beh_feature(IA,6);
        Group_ind = Image_sublist(IB,5);
        all_feature = [Group_ind BPI_features(IB,region_ind) Group_ind.*BPI_features(IB,region_ind)];
    end
    Subjects_Data = all_feature;
    
    [bb,dev,stats] = glmfit(Subjects_Data,Subjects_Scores);
    all_p(:,region_ind)=stats.p;
    
    [b,r,SSE,SSR, T, TF_ForContrast, Cohen_f2] = y_regress_ss(Subjects_Scores,[ones(length(Subjects_Scores),1) Subjects_Data],[0 0 0 1],'F');
    
    F_all(:,region_ind)=TF_ForContrast;
    Cohen_f2_all(:,region_ind)=Cohen_f2;
end
