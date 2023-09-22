clear,clc
% setting behavioral data path
file_path = 'pwd';

%% subjectlist of the project
load('info_sub63.mat'); 
final_all = array2table(Sub_info63,'VariableNames',{'PID','AgePre','AgePost','gender','group'})

%% learning rate data
load(fullfile(file_path,'7. data, scripts and results','analysis','Behavior','tutoring performance','IEF_tutoring.mat'));
load(fullfile(file_path,'7. data, scripts and results','analysis','Behavior','tutoring performance','learning_rate_IES.mat'));
[C,IA,IB]=intersect(Sub_info63(:,1),IEF_tutoring(:,1));
clear temp

PID= IEF_tutoring(IB,1);
day1 = IEF_tutoring(IB,2);
day2 = IEF_tutoring(IB,3);
day3 = IEF_tutoring(IB,4);
day4 = IEF_tutoring(IB,5);
day5 = IEF_tutoring(IB,6);

day1_label = ones(length(C),1);
day2_label = ones(length(C),1).*2;
day3_label = ones(length(C),1).*3;
day4_label = ones(length(C),1).*4;
day5_label = ones(length(C),1).*5;

group_label = Sub_info63(IA,5);

IEF_data_for_bf = [PID day1 day1_label group_label];
IEF_data_for_bf = [IEF_data_for_bf; [PID day2 day2_label group_label]]
IEF_data_for_bf = [IEF_data_for_bf; [PID day3 day3_label group_label]]
IEF_data_for_bf = [IEF_data_for_bf; [PID day4 day4_label group_label]]
IEF_data_for_bf = [IEF_data_for_bf; [PID day5 day5_label group_label]]

temp=array2table(IEF_data_for_bf,'VariableNames',{'PID','IES','Day','Group'})

