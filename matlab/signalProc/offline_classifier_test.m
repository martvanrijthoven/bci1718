try; cd(fileparts(mfilename('fullpath')));catch; end;
try;
   run ../../matlab/utilities/initPaths.m
catch
   msgbox({'Please change to the directory where this file is saved before running the rest of this code'},'Change directory'); 
end

util_folder = '../utilities';
addpath(fullfile(util_folder));
load '../../data/training_data_test_180117_Emiel1015.mat'

capFile='cap_project';
clsfr=buffer_train_ersp_clsfr(traindata,traindevents,hdr,'spatialfilter','car','freqband',[6 8 17 19],'capFile',capFile,'overridechnms',1);clsfr=buffer_train_ersp_clsfr(traindata,traindevents,hdr,'spatialfilter','car','freqband',[6 8 17 19],'capFile',capFile,'overridechnms',1);

%%
load '../../data/training_data_test_180118_Emiel1015.mat'

output=buffer_apply_ersp_clsfr(traindata,clsfr)

% include performance test