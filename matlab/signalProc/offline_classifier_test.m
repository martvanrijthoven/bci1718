try; cd(fileparts(mfilename('fullpath')));catch; end;
try;
   run ../../matlab/utilities/initPaths.m
catch
   msgbox({'Please change to the directory where this file is saved before running the rest of this code'},'Change directory'); 
end

util_folder = '../utilities';
addpath(fullfile(util_folder));
load '../../data/training_data_test_Emiel1015_firstThree.mat'

% signal-processing configuration
% for 10Hz and 15Hz
% freqband      =[6 8 17 19];
% for 15Hz and 20Hz
% freqband      =[11 13 22 24];
% for 10Hz and 20Hz
% freqband      =[6 8 22 24];

capFile='cap_project';
[clsfr,res,X,Y]=buffer_train_ersp_clsfr(traindata,traindevents,hdr,'spatialfilter','wht','freqband',[6 8 17 19],'capFile',capFile,'overridechnms',1,'badtrrm',1,'badchrm',1,'verb',0,'width_ms',250,'objFn','mlr_cg','binsp',0,'spMx','1vR');
%save(['clsfr_1015_firstThree' '.mat'],'-struct','clsfr');
%%
load '../../data/training_data_test_180124_Emiel1015.mat'

[f,fraw,p,X]=buffer_apply_ersp_clsfr(traindata,clsfr);
%f=d
%f=tprod(f,[1 -2],clsfr.spMx,[-ndims(f) 2])
'done'
%% include performance test

% now f<0 is taken as the left target, not sure if that is correct ^Emiel
for idx = 1:numel(f)
    if f(idx)>=0
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