% connect part

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

buffer_newevents(buffhost, buffport, [], {'experiment'}, {'start'}, 10000);


screensize = get(0,'ScreenSize');
screensize = screensize(3:4);

leftx = screensize(1)/3*2;
rightx = screensize(1)/3;


f = figure('Position',[leftx,0,rightx,screensize(1)]);
set(f, 'MenuBar', 'none');
set(f, 'ToolBar', 'none');


% the flashing block on frequency
t = timer;
set(t, 'executionMode', 'fixedRate');
freq = 15;
period = 1/freq;
set(t, 'Period', 1/freq);
set(t, 'TimerFcn', 'show');
flash = true;

RectPos = [2,4,6,3];

%// Set the visible property to off.
show = rectangle('Position',RectPos,'FaceColor', [0.8, 0.8, 0.8], 'Visible','off');
hide = rectangle('Position',RectPos,'FaceColor','k','Visible','off');
axis([0 10 0 10])
% set the background to black
set (gcf, 'Color', [0 0 0] );
set (gca, 'Color', [0 0 0] );

while true

%// Play with the "Visible" property to show/hide the rectangles.
    set(show,'Visible','on')

    pause(period)

    set(show,'Visible','off')
    set(hide,'Visible','on');
    drawnow

    pause(period)

    set(hide,'Visible','off');

    set(gca,'xcolor',get(gcf,'color'));
    set(gca,'ycolor',get(gcf,'color'));
    set(gca,'ytick',[]);
    set(gca,'xtick',[]);
end