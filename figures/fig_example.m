
function fig_example()
    %% FIG_EXAMPLE()
    % example of the use of fig_ functions

    %% figure
    f = figure();

    % BARWEB
    subplot(2,1,1);
    % fig_bare
    y   = randi(10,2,5);
    e   = y .* 0.2 .* rand(2,5);
    c   = fig_color('work');
    web = fig_bare(y,e,'work',{'group A','group B'},{'Alice','Bob','Charlie','Denver','Ellie'});
    % fig_axis
    sa_barweb = struct();
    sa_barweb.title   = 'FIGURE BAR WEB';
    sa_barweb.xlabel  = 'x label';
    sa_barweb.ylabel  = 'y label';
    va_barweb = fig_axis(sa_barweb);

    % AXIS
    subplot(2,1,2);
    % fig_plot
    t = linspace(0,8*pi,10);
    tt = repmat(linspace(0,8*pi,10),20,1);
    ss = cos(tt);
    rr = randn(size(tt));
    yy = ss+rr;
    my = nanmean(yy);
    sy = nanstd(yy);
    sp = fig_combination({'marker','shade','pip'},t,my,sy);
    % fig_axis
    sa_plot = struct();
    sa_plot.ilegend = sp.pip;
    sa_plot.tlegend = 'legend';
    sa_plot.title   = 'FIGURE PLOT';
    sa_plot.xlabel  = 'x label';
    sa_plot.ylabel  = 'y label';
    sa_plot.xtick   = t(1):5:t(end);
    sa_plot.xlim    = [t(1),t(end)];
    sa_plot.ytick   = -1:+1;
    sa_plot.ylim    = [-2,+2];
    va_plot = fig_axis(sa_plot);

    % FIGURE
    fig_figure(f);
    
    %% slider
    [m{1:5}] = ndgrid(1:41,1:41,1:21,1:21,1:21);
    e = '%+.2f';
    v = cos(0.05 * m{3} .* sqrt(power(m{1}-m{4},2) + power(m{2}-m{5},2)));
    x = arrayfun(@(x)num2leg(linspace(-1,+1,x),e),size(v),'UniformOutput',false);
    l = {'DIM_1','DIM_2','dimension 3','dimension 4','dimension 5'};
    fig_slider(v,x,l,e);
end