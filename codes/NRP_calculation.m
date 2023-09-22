clear,clc
%% NRP calculation
% This script is used to calculate the neural representational plasticity 
% between pre and post- training for train and untrained problems
% for each subjects in ASD project
%
% Jin Liu
% 1/6/2021
%
%% setting file path and loading data
% setting project path
addpath('DPABI_V4.2_190919');
oak_path = fullfile('2019_ASD_MathWhiz');

% NRP calculation
twogroup = {'ASD';'TD'};
contrast = {'trained-rest';'untrained-rest'};

for u=1:2
    for l=1:2
        mkdir(fullfile(oak_path,'results','taskfmri','groupstats','rsa',[contrast{u} '_pre_VS_' contrast{u} '_post'],'analysis',['NRD_' twogroup{l}]));
        
        input_path = fullfile(oak_path,'results','taskfmri','groupstats','rsa', [contrast{u} '_pre_VS_' contrast{u} '_post'],'analysis',twogroup{l},filesep);
        file_path=dir(input_path);
        file_path(1:2,:)=[];
        
        for i=1:length(file_path)
            Y_temp =zeros(91,109,91);
            
            AllVolume = [input_path,file_path(i).name];
            V = spm_vol(AllVolume);
            [Y_temp,XYZmm]=spm_read_vols(V);
            
            Y_change=-Y_temp;
            OutputName = fullfile(oak_path,'results','taskfmri','groupstats','rsa',[contrast{u} '_pre_VS_' contrast{u} '_post'],'analysis', ['NRD_' twogroup{l}],[file_path(i).name(1:4),'_NRD_plasticity.nii']);
            y_Write(Y_change,V,OutputName);
        end
    end
end

