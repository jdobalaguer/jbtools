%  ANALYSIS internal script

function analysis_plot_do(obj,fig_type)
    
    %% variables

    % unique
    u_ssdata = get(obj.obj.sdata.objects.list,'String');
    u_sx     = get(obj.obj.axis.objects.xlist,'String');
    u_sy     = get(obj.obj.axis.objects.ylist,'String');
    % index
    i_ssdata = get(obj.obj.sdata.objects.list,'Value');
    i_sx     = get(obj.obj.axis.objects.xlist,'Value');
    i_sy     = get(obj.obj.axis.objects.ylist,'Value');
    % string
    if ischar(u_ssdata), ss_sdata = u_ssdata; else ss_sdata = u_ssdata{i_ssdata}; end
    if ischar(u_sx    ), ss_x     = u_sx    ; else ss_x     = u_sx{i_sx};         end
    if ischar(u_sy    ), ss_y     = u_sy    ; else ss_y     = u_sy{i_sy};         end

    %% return
    if strcmp(ss_sdata,' '), return; end
    if strcmp(ss_x    ,' '), return; end
    if strcmp(ss_y    ,' '), return; end

    %% values
    x         = evalin('base',sprintf('%s.%s',ss_sdata,ss_x));
    y         = evalin('base',sprintf('%s.%s',ss_sdata,ss_y));
    % reshape
    x = x(:);
    if (size(y,2)==length(x)), y = y'; end

    %% assert
    assert(size(y,1)==length(x) || size(y,2)==length(x),'analysis: error. vectors have different length');

    %% statistics

    % x values
    u_x  = unique(x);
    u_x  = u_x(:);
    nb_x = length(u_x);
    l_x  = length(x);

    % y values
    m_y = nan(nb_x,1);
    e_y = nan(nb_x,1);
    for i = 1:nb_x
        ii      = (x == u_x(i));
        m_y(i)  = nanmean(y(ii,:));
        e_y(i)  = nanste( y(ii,:));
    end

    %% figure (last is "new figure")
    i_fig  = get(obj.obj.figure.objects.list,'Value');
    u_fig  = get(obj.obj.figure.objects.list,'String');
    nb_fig = length(u_fig);

    if (i_fig == nb_fig)
        analysis_figure_new;
        h_fig = gcf();
    else
        h_fig = obj.fig{i_fig}.handle;
        figure(h_fig);
    end
    obj.obj.figure.refresh();

    %% hold
    hold_on = get(obj.obj.figure.objects.hold,'Value');
    if hold_on, hold('on');
    else        hold('off');
                clf(h_fig);
    end

    %% plot
    switch(fig_type)
        case 'plot'
            plot(u_x,m_y,'.');
        case 'fig_plot'
            fig_plot(u_x,m_y,e_y);
        case 'fig_barweb'
            m_y = m_y';
            e_y = e_y';
            web = fig_barweb(   m_y,... height
                                e_y,... error
                                [], ... width
                                [], ... group
                                [], ... title
                                [], ... xlabel
                                [], ... ylabel
                                [], ... colour
                                [], ... grid
                                num2leg(u_x), ... legend
                                [], ... error sides (1, 2)
                                'axis' ... legend style ('plot','axis')
                                );

    end
    fig_axis();
    fig_figure(gcf());
end