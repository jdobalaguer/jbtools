function fig_example()
    %% fig_example()
    %
    % example of the use of fig_ functions
    %

    %% figure
    f = figure();

    %% barweb
    subplot(2,1,1);
    % fig_barweb
    y   = randi(10,2,5);
    e   = y .* 0.2 .* rand(2,5);
    c   = fig_color('work')./255;
    web = fig_barweb(   y,e,...                                                height and error
                        [],...                                                 width
                        {'condition A','condition B'},...                      group names
                        [],...                                                 title
                        [],...                                                 xlabel
                        [],...                                                 ylabel
                        c,...                                                  colour
                        [],...                                                 grid
                        {'Alice','Bob','Charlie','Denver','Ellie'},...         legend
                        [],...                                                 error sides (1, 2)
                        'axis'...                                              legend ('plot','axis')
                        );
    % fig_axis
    sa_barweb = struct();
    sa_barweb.title   = 'FIGURE BAR WEB';
    sa_barweb.xlabel  = 'x label';
    sa_barweb.ylabel  = 'y label';
    va_barweb = fig_axis(sa_barweb);

    %% axis
    subplot(2,1,2);
    % fig_plot
    t = linspace(0,8*pi,10);
    tt = repmat(linspace(0,8*pi,10),20,1);
    ss = cos(tt);
    rr = randn(size(tt));
    yy = ss+rr;
    my = nanmean(yy);
    sy = nanstd(yy);
    pl = fig_plot(t,my,sy);
    % fig_axis
    sa_plot = struct();
    sa_plot.ilegend = pl;
    sa_plot.title   = 'FIGURE PLOT';
    sa_plot.xlabel  = 'x label';
    sa_plot.ylabel  = 'y label';
    sa_plot.xtick   = t(1):5:t(end);
    sa_plot.xlim    = [t(1),t(end)];
    sa_plot.ytick   = -1:+1;
    va_plot = fig_axis(sa_plot);

    %% set figure
    fig_figure(f);

    %% save
    fig_export('fig_example.pdf');
    
end