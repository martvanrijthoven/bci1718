try; cd(fileparts(mfilename('fullpath')));catch; end;
try;
   run ../../matlab/utilities/initPaths.m
catch
   msgbox({'Please change to the directory where this file is saved before running the rest of this code'},'Change directory'); 
end

util_folder = '../utilities';
addpath(fullfile(util_folder));
load '../../data/training_data_test_Emiel1015_firstThree.mat'

capFile='cap_project';
clsfr=buffer_train_ersp_clsfr(traindata,traindevents,hdr,'spatialfilter','car','freqband',[6 8 17 19],'capFile',capFile,'overridechnms',1);clsfr=buffer_train_ersp_clsfr(traindata,traindevents,hdr,'spatialfilter','car','freqband',[6 8 17 19],'capFile',capFile,'overridechnms',1);

%%
load '../../data/training_data_test_180124_Emiel1015.mat'

[f,fraw,p,X]=buffer_apply_ersp_clsfr(traindata,clsfr);

%% include performance test

% now f<0 is taken as the left target, not sure if that is correct ^Emiel
for idx = 1:numel(f)
    if f(idx)<=0
        f(idx)=1;
    else
        f(idx)=2;
    end
end

output = [];
labels=extractfield(traindevents,'value');
for idx = 1:numel(f)
    if f(idx)==labels(idx)
        output(idx)=1
    else
        output(idx)=0
    end
end
mean(output)