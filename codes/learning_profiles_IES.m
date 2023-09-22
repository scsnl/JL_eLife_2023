clear,clc
%% Learning profiles
% This script is used to calculate and plot the learning rate by fitting a linear
% regression model for each participant on inverse efficiency score(response time/(1-error rate) performances 
% in computerized training task (pirate game) during five days training in ASD Whizz project
%
% Jin Liu
% 6/6/2023
%
%% setting file path and loading data
% setting project path
file_path = 'pwd';

% addpath for stat code
addpath(fullfile(file_path,'stat_code','mixed_between_within_anova')); % two-way repeated measures anova.m
addpath(fullfile(file_path,'stat_code','RMAOV1')); % one-way repeated measures anova.m
addpath(fullfile(file_path,'stat_code','computeCohen_d'));

% setting behavioral data path
load('PirateGame_subjectlist.mat'); % subjectlist of the project (Sub_info55)

% loading behavioral data
load('PirateGame_All_Data.mat'); % PID day correct_responseT accuracy_whole

% report number of participant for each group
num_ASD=length(find(Sub_info55(:,5)==1));
num_TD=length(find(Sub_info55(:,5)==2));

fprintf(['Number of participants for analysis: ASD = ' num2str(num_ASD) ' TD = ' num2str(num_TD) '\n\n']);

%% calculating ES
% Accuracy
ACC_tutoring = zeros(length(Sub_info55),6); % Accuracy from Day1 to Day5 for each participant
ACC_tutoring(:,1)=Sub_info55(:,1);
for i=1:length(Sub_info55)
    for j=1:5
        temp = accuracy_whole(find(PID==tutoring_sublist(i) & day == j));
        ACC_tutoring(i,j+1) = sum(temp)/length(temp); % (%)
    end
end

% error rate
ER_tutoring = zeros(length(Sub_info55),6); % Accuracy from Day1 to Day5 for each participant
ER_tutoring(:,1)=Sub_info55(:,1);
for i=1:length(Sub_info55)
    for j=1:5
        temp = accuracy_whole(find(PID==tutoring_sublist(i) & day == j));
        ER_tutoring(i,j+1) = length(find(temp==0))/length(temp); % (%)
    end
end

% Response time (only correct trials)
RT_tutoring = zeros(length(Sub_info55),6); % Mean RT from Day1 to Day5 for each participant
RT_tutoring(:,1)=Sub_info55(:,1);
for i=1:length(Sub_info55)
    for j=1:5
        temp = correct_responseT(find(PID == tutoring_sublist(i) & day == j & accuracy_whole == 1));
        RT_tutoring(i,j+1) = sum(temp)*0.001/length(temp); % (s)
    end
end

% Efficiency (ACC/RT)
EF_tutoring = zeros(length(Sub_info55),6);
EF_tutoring(:,1)=Sub_info55(:,1);
EF_tutoring(:,2:6) = ACC_tutoring(:,2:6)./(RT_tutoring(:,2:6));

% inverse Efficiency (RT/(1-error rate)
IEF_tutoring = zeros(length(Sub_info55),6);
IEF_tutoring(:,1)=Sub_info55(:,1);
IEF_tutoring(:,2:6) = (RT_tutoring(:,2:6))./(1-ER_tutoring(:,2:6));

% testing assumption of IEF
[r p]=corr(RT_tutoring(:,2),ER_tutoring(:,2))
[r p]=corr(RT_tutoring(:,3),ER_tutoring(:,3))
[r p]=corr(RT_tutoring(:,4),ER_tutoring(:,4))
[r p]=corr(RT_tutoring(:,5),ER_tutoring(:,5))
[r p]=corr(RT_tutoring(:,6),ER_tutoring(:,6))

length(find(ER_tutoring(:,2:end)>0.2))/275
length(find(mean(ER_tutoring(:,2:end))>0.2))/55

%% Two-way (session/day by group) repeated measures ANOVA
% IES
fprintf('Two-way repeated measures ANOVA results for IES');
data_for_anova = [IEF_tutoring(:,2);IEF_tutoring(:,3);IEF_tutoring(:,4);IEF_tutoring(:,5);IEF_tutoring(:,6)];
group = [Sub_info55(:,5);Sub_info55(:,5);Sub_info55(:,5);Sub_info55(:,5);Sub_info55(:,5)];
session_day = [ones(size(IEF_tutoring,1),1);ones(size(IEF_tutoring,1),1)*2;ones(size(IEF_tutoring,1),1)*3;ones(size(IEF_tutoring,1),1)*4;ones(size(IEF_tutoring,1),1)*5];
sub_ind = [(1:length(IEF_tutoring))';(1:length(IEF_tutoring))';(1:length(IEF_tutoring))';(1:length(IEF_tutoring))';(1:length(IEF_tutoring))'];
X = [data_for_anova group session_day sub_ind];
[SSQs, DFs, MSQs, Fs, Ps]=mixed_between_within_anova(X,0);
% effect size 
partial_eta_square = SSQs{3}/(SSQs{3}+SSQs{5})
partial_eta_square = SSQs{1}/(SSQs{1}+SSQs{2})
partial_eta_square = SSQs{4}/(SSQs{4}+SSQs{5})

% ACC for SI
fprintf('Two-way repeated measures ANOVA results for ACC');
data_for_anova = [ACC_tutoring(:,2);ACC_tutoring(:,3);ACC_tutoring(:,4);ACC_tutoring(:,5);ACC_tutoring(:,6)];
group = [Sub_info55(:,5);Sub_info55(:,5);Sub_info55(:,5);Sub_info55(:,5);Sub_info55(:,5)];
session_day = [ones(size(ACC_tutoring,1),1);ones(size(ACC_tutoring,1),1)*2;ones(size(ACC_tutoring,1),1)*3;ones(size(ACC_tutoring,1),1)*4;ones(size(ACC_tutoring,1),1)*5];
sub_ind = [(1:length(ACC_tutoring))';(1:length(ACC_tutoring))';(1:length(ACC_tutoring))';(1:length(ACC_tutoring))';(1:length(ACC_tutoring))'];
X = [data_for_anova group session_day sub_ind];
[SSQs, DFs, MSQs, Fs, Ps]=mixed_between_within_anova(X,0);
% effect size 
partial_eta_square = SSQs{3}/(SSQs{3}+SSQs{5})
partial_eta_square = SSQs{1}/(SSQs{1}+SSQs{2})
partial_eta_square = SSQs{4}/(SSQs{4}+SSQs{5})

% RT for SI
fprintf('Two-way repeated measures ANOVA results for RT');
data_for_anova = [RT_tutoring(:,2);RT_tutoring(:,3);RT_tutoring(:,4);RT_tutoring(:,5);RT_tutoring(:,6)];
group = [Sub_info55(:,5);Sub_info55(:,5);Sub_info55(:,5);Sub_info55(:,5);Sub_info55(:,5)];
session_day = [ones(size(RT_tutoring,1),1);ones(size(RT_tutoring,1),1)*2;ones(size(RT_tutoring,1),1)*3;ones(size(RT_tutoring,1),1)*4;ones(size(RT_tutoring,1),1)*5];
sub_ind = [(1:length(RT_tutoring))';(1:length(RT_tutoring))';(1:length(RT_tutoring))';(1:length(RT_tutoring))';(1:length(RT_tutoring))'];
X = [data_for_anova group session_day sub_ind];
[SSQs, DFs, MSQs, Fs, Ps]=mixed_between_within_anova(X,0);
% effect size 
partial_eta_square = SSQs{3}/(SSQs{3}+SSQs{5})
partial_eta_square = SSQs{1}/(SSQs{1}+SSQs{2})
partial_eta_square = SSQs{4}/(SSQs{4}+SSQs{5})

%% posthoc one-way repeated measures ANOVA
% ASD
fprintf('---------------------------------------------------------------------------\n');
fprintf('One-way repeated measures ANOVA results for ES in ASD\n\n');
depen_var = [IEF_tutoring(find(Sub_info55(:,5)==1),2);IEF_tutoring(find(Sub_info55(:,5)==1),3);IEF_tutoring(find(Sub_info55(:,5)==1),4);IEF_tutoring(find(Sub_info55(:,5)==1),5);IEF_tutoring(find(Sub_info55(:,5)==1),6)];
indep_var = [ones(size(find(Sub_info55(:,5)==1),1),1);ones(size(find(Sub_info55(:,5)==1),1),1)*2;ones(size(find(Sub_info55(:,5)==1),1),1)*3;ones(size(find(Sub_info55(:,5)==1),1),1)*4;ones(size(find(Sub_info55(:,5)==1),1),1)*5];
sub_ind = [(1:length(find(Sub_info55(:,5)==1)))';(1:length(find(Sub_info55(:,5)==1)))';(1:length(find(Sub_info55(:,5)==1)))';(1:length(find(Sub_info55(:,5)==1)))';(1:length(find(Sub_info55(:,5)==1)))'];
X =[depen_var,indep_var,sub_ind];
[eta2]=RMAOV1(X,0.05); 
% effect size
partial_eta_square = eta2

% TD
fprintf('One-way repeated measures ANOVA results for ES in TD\n');
depen_var = [IEF_tutoring(find(Sub_info55(:,5)==2),2);IEF_tutoring(find(Sub_info55(:,5)==2),3);IEF_tutoring(find(Sub_info55(:,5)==2),4);IEF_tutoring(find(Sub_info55(:,5)==2),5);IEF_tutoring(find(Sub_info55(:,5)==2),6)];
indep_var = [ones(size(find(Sub_info55(:,5)==2),1),1);ones(size(find(Sub_info55(:,5)==2),1),1)*2;ones(size(find(Sub_info55(:,5)==2),1),1)*3;ones(size(find(Sub_info55(:,5)==2),1),1)*4;ones(size(find(Sub_info55(:,5)==2),1),1)*5];
sub_ind = [(1:length(find(Sub_info55(:,5)==2)))';(1:length(find(Sub_info55(:,5)==2)))';(1:length(find(Sub_info55(:,5)==2)))';(1:length(find(Sub_info55(:,5)==2)))';(1:length(find(Sub_info55(:,5)==2)))'];
X =[depen_var,indep_var,sub_ind];
[eta2]=RMAOV1(X,0.05); 
% effect size
partial_eta_square = eta2

%% posthoc two-sample t-test
[h,p,ci,stats] = ttest2(IEF_tutoring(find(Sub_info55(:,5)==1),2),IEF_tutoring(find(Sub_info55(:,5)==2),2)); % day 1
t_session(1)=stats.tstat;p_session(1)=p; df_session(1)=stats.df; 
[h,p,ci,stats] = ttest2(IEF_tutoring(find(Sub_info55(:,5)==1),3),IEF_tutoring(find(Sub_info55(:,5)==2),3)); % day 2
t_session(2)=stats.tstat;p_session(2)=p; df_session(2)=stats.df;
[h,p,ci,stats] = ttest2(IEF_tutoring(find(Sub_info55(:,5)==1),4),IEF_tutoring(find(Sub_info55(:,5)==2),4)); % day 3
t_session(3)=stats.tstat;p_session(3)=p; df_session(3)=stats.df;
[h,p,ci,stats] = ttest2(IEF_tutoring(find(Sub_info55(:,5)==1),5),IEF_tutoring(find(Sub_info55(:,5)==2),5)); % day 4
t_session(4)=stats.tstat;p_session(4)=p; df_session(4)=stats.df;
[h,p,ci,stats] = ttest2(IEF_tutoring(find(Sub_info55(:,5)==1),6),IEF_tutoring(find(Sub_info55(:,5)==2),6)); % day 5
t_session(5)=stats.tstat;p_session(5)=p; df_session(5)=stats.df;
mean_sd = [mean(IEF_tutoring(find(Sub_info55(:,5)==1),2:6))',std(IEF_tutoring(find(Sub_info55(:,5)==1),2:6))',mean(IEF_tutoring(find(Sub_info55(:,5)==2),2:6))',std(IEF_tutoring(find(Sub_info55(:,5)==2),2:6))'];

d(1) = computeCohen_d(IEF_tutoring(find(Sub_info55(:,5)==1),2),IEF_tutoring(find(Sub_info55(:,5)==2),2));
d(2) = computeCohen_d(IEF_tutoring(find(Sub_info55(:,5)==1),3),IEF_tutoring(find(Sub_info55(:,5)==2),3));
d(3) = computeCohen_d(IEF_tutoring(find(Sub_info55(:,5)==1),4),IEF_tutoring(find(Sub_info55(:,5)==2),4));
d(4) = computeCohen_d(IEF_tutoring(find(Sub_info55(:,5)==1),5),IEF_tutoring(find(Sub_info55(:,5)==2),5));
d(5) = computeCohen_d(IEF_tutoring(find(Sub_info55(:,5)==1),6),IEF_tutoring(find(Sub_info55(:,5)==2),6));

disp('Two-sample Ttest Analysis Table for ES in each day')
fprintf('-------------------------------------------------------------------------------\n');
disp('        ASD(mean) ASD(sd) TD(mean)  TD(sd)     t       df    Cohen''s d    P')
fprintf('-------------------------------------------------------------------------------\n');
fprintf('Day1 %9.2f%9.2f%9.2f%9.2f%9.2f%9.2f%9.2f%9.2f\n\n', mean_sd(1,1),mean_sd(1,2),mean_sd(1,3),mean_sd(1,4),t_session(1),df_session(1),d(1),p_session(1));
fprintf('Day2 %9.2f%9.2f%9.2f%9.2f%9.2f%9.2f%9.2f%9.2f\n\n', mean_sd(2,1),mean_sd(2,2),mean_sd(2,3),mean_sd(2,4),t_session(2),df_session(2),d(2),p_session(2));
fprintf('Day3 %9.2f%9.2f%9.2f%9.2f%9.2f%9.2f%9.2f%9.2f\n\n', mean_sd(3,1),mean_sd(3,2),mean_sd(3,3),mean_sd(3,4),t_session(3),df_session(3),d(3),p_session(3));
fprintf('Day4 %9.2f%9.2f%9.2f%9.2f%9.2f%9.2f%9.2f%9.2f\n\n', mean_sd(4,1),mean_sd(4,2),mean_sd(4,3),mean_sd(4,4),t_session(4),df_session(4),d(4),p_session(4));
fprintf('Day5 %9.2f%9.2f%9.2f%9.2f%9.2f%9.2f%9.2f%9.2f\n\n', mean_sd(5,1),mean_sd(5,2),mean_sd(5,3),mean_sd(5,4),t_session(5),df_session(5),d(5),p_session(5));
fprintf('-------------------------------------------------------------------------------\n');

%% save ES measures
IEF_tutoring_title={'PID','D1','D2','D3','D4','D5'};
save(fullfile(file_path,'IEF_tutoring.mat'),'IEF_tutoring','IEF_tutoring_title');

%% plot group-average learning curve across day
output_path =fullfile(file_path,'results','Behavior','figures','ASD_TD_training_day1_5_IEF.tiff');
line_averge_twogroup(IEF_tutoring(find(Sub_info55(:,5)==1),2:6),IEF_tutoring(find(Sub_info55(:,5)==2),2:6),[255/255 166/255 158/255],[157/255,211/255,250/255], [1 10], {'Day1','Day2','Day3','Day4','Day5'}, 'Training task','Inverse efficiency score', output_path);

%% learning rate analysis
% calculating learning rate
% fitting with linear regression model for each participant
for i = 1:length(Sub_info55)
  [p] = polyfit([1:5]',IEF_tutoring(i,2:6)',1);
  lr(i,1)=p(1);
end
x = lr(Sub_info55(:,5)==1);% ASD learning rate
y = lr(Sub_info55(:,5)==2);% TD learning rate

% statistics for group differences in learning rate
[h,p,ci,stats] = ttest2(x,y);
clear d
d = computeCohen_d(x,y);

disp('Two-sample Ttest Analysis Table for learning rate')
fprintf('------------------------------------------------------------------------------\n');
disp('      ASD(mean) ASD(sd) TD(mean) TD(sd)     t       df        d       P')
fprintf('------------------------------------------------------------------------------\n');
fprintf('  %9.2f%9.3f%9.2f%9.3f%9.2f%9.2f%9.2f%9.3f\n\n', mean(x),std(x),mean(y),std(y),stats.tstat,stats.df,d,p);
fprintf('------------------------------------------------------------------------------\n');
    
% plot learning rate 
output_path = fullfile(file_path,'results','Behavior','figures','ASD_TD_trainingrate.tiff');
bar_group(x,y,[-4 1],[-4:1:1],[-4:1:1], {'ASD','TD'}, 'Learning rate', output_path);

% save learning rate measures 
learning_rate_IES(:,1)=Sub_info55(:,1);
learning_rate_IES(:,2)=Sub_info55(:,5);
learning_rate_IES(:,3)=lr;

learning_rate_IES_title={'PID','ASD/TD','learning rate (IES)'};
save(fullfile(file_path,'learning_rate_IES.mat'),'learning_rate_IES','learning_rate_IES_title');
