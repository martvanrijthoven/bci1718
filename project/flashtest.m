
figure

% the flashing block on frequency
t = timer;
set(t, 'executionMode', 'fixedRate');
freq = 10;
period = 1/freq;
set(t, 'Period', 1/freq);
set(t, 'TimerFcn', 'show');
flash = true;

RectPos = [0,0,1,1];

%// Set the visible property to off.
    show = rectangle('Position',RectPos,'FaceColor','w','Visible','off');
    hide = rectangle('Position',RectPos,'FaceColor','k','Visible','off');

% set the background to black
set (gcf, 'Color', [0 0 0] );

while true;

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