util_folder = '../utilities';
addpath(fullfile(util_folder));
load '../../data/training_data_test_180117_Emiel1015.mat'

capFile='cap_project';
clsfr=buffer_train_ersp_clsfr(traindata,traindevents,hdr,'spatialfilter','car','freqband',[6 8 17 19],'capFile',capFile,'overridechnms',1);