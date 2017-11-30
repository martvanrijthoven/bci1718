try; cd(fileparts(mfilename('fullpath')));catch; end;
try;
   run ../matlab/utilities/initPaths.m
catch
   msgbox({'Please change to the directory where this file is saved before running the rest of this code'},'Change directory'); 
end

buffhost='localhost';buffport=1972;
% wait for the buffer to return valid header information
hdr=[];
while ( isempty(hdr) || ~isstruct(hdr) || (hdr.nchans==0) ) % wait for the buffer to contain valid data
  try 
    hdr=buffer('get_hdr',[],buffhost,buffport); 
  catch
    hdr=[];
    fprintf('Invalid header info... waiting.\n');
  end;
  pause(1);
end;

% set the real-time-clock to use
initsleepSec;
initgetwTime;

verb=0;
nSymbs=2;
nSeq=15;
nBlock=2;%10; % number of stim blocks to use
trialDuration=3;
baselineDuration=1;
intertrialDuration=2;

bgColor=[.5 .5 .5];
tgtColor=[0 1 0];
fixColor=[1 0 0];


% make the target sequence
tgtSeq=mkStimSeqRand(nSymbs,nSeq);

% make the stimulus
%figure;
fig=gcf;
set(fig,'Name','Imagined Movement','color',[0 0 0],'menubar','none','toolbar','none','doublebuffer','on');
clf;
ax=axes('position',[0.025 0.025 .95 .95],'units','normalized','visible','off','box','off',...
        'xtick',[],'xticklabelmode','manual','ytick',[],'yticklabelmode','manual',...
        'color',[0 0 0],'DrawMode','fast','nextplot','replacechildren',...
        'xlim',[-1.5 1.5],'ylim',[-1.5 1.5],'Ydir','normal');
right=text(.5,.5,'text','HorizontalAlignment','center','VerticalAlignment','middle',...
       'FontUnits','normalized','fontsize',.2,'color',[1 1 0],'visible','off'); 
left=text(.5,.5,'text','HorizontalAlignment','center','VerticalAlignment','middle',...
       'FontUnits','normalized','fontsize',.2,'color',[0 0 1],'visible','off'); 
set(right, 'string', '>');
set(left, 'string', '<');
   
stimRadius=.5;
theta=linspace(0,pi,nSymbs);
% add symbol for the center of the screen
h=rectangle('curvature',[1 1],'position',[0-stimRadius/4;0-stimRadius/4;stimRadius/2*[1;1]],...
                      'facecolor',bgColor); 
set(gca,'visible','on');

% play the stimulus
% reset the cue and fixation point to indicate trial has finished  
set(h,'facecolor',bgColor);
set(right, 'position', [0;0]);
set(left, 'position', [0;0]);
sendEvent('stimulus.training','start');
drawnow; pause(5); % N.B. pause so fig redraws

for si=1:nSeq;

  if ( ~ishandle(fig) ) break; end;

  sleepSec(intertrialDuration);
  % show the screen to alert the subject to trial start
  set(h,'facecolor',fixColor); % red fixation indicates trial about to start/baseline
  drawnow;% expose; % N.B. needs a full drawnow for some reason
  sendEvent('stimulus.baseline','start');
  sleepSec(baselineDuration);
  sendEvent('stimulus.baseline','end');
  
  
  % show the target
  fprintf('%d) tgt=%d : ',si,find(tgtSeq(:,si)>0));
  set(h,'visible','off');
  tgt = find(tgtSeq(:,si)>0);
  if tgt==1
      set(right, 'visible', 'on');
  elseif tgt==2
      set(left, 'visible', 'on')
  end
  sendEvent('stimulus.target',find(tgtSeq(:,si)>0));
  drawnow;% expose; % N.B. needs a full drawnow for some reason
  sendEvent('stimulus.trial','start');
  % wait for trial end
  sleepSec(trialDuration);
  
  % reset the cue and fixation point to indicate trial has finished  
  if tgt==1
      set(right, 'visible', 'off');
  elseif tgt==2
      set(left, 'visible', 'off')
  end
  set(h,'facecolor',bgColor);
  set(h,'visible','on');
  drawnow;
  sendEvent('stimulus.trial','end');
  
  fprintf('\n');
end % sequences
% end training marker
sendEvent('stimulus.training','end');

% thanks message
text(mean(get(ax,'xlim')),mean(get(ax,'ylim')),{'That ends the training phase.','Thanks for your patience'},'HorizontalAlignment','center','color',[0 1 0],'fontunits','normalized','FontSize',.1);
pause(3);
