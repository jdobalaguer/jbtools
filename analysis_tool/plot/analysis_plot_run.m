%  ANALYSIS internal script

%% variables

% unique
u_ssdata = get(obj.obj.sdata.objects.list,'String');
u_sx     = get(obj.obj.axis.objects.xlist,'String');
u_sy     = get(obj.obj.axis.objects.ylist,'String');
u_sf     = get(obj.obj.filter.objects.list,'String');
% number
nb_sf    = length(u_sf);
% index
i_ssdata = get(obj.obj.sdata.objects.list,'Value');
i_sx     = get(obj.obj.axis.objects.xlist,'Value');
i_sy     = get(obj.obj.axis.objects.ylist,'Value');
i_sf     = get(obj.obj.filter.objects.list,'Value');
% string
if ischar(u_ssdata), ss_sdata = u_ssdata; else ss_sdata = u_ssdata{i_ssdata}; end
if ischar(u_sx    ), ss_x     = u_sx    ; else ss_x     = u_sx{i_sx};         end
if ischar(u_sy    ), ss_y     = u_sy    ; else ss_y     = u_sy{i_sy};         end
if ischar(u_sf    ), ss_f     = u_sf    ; else ss_f     = u_sf{i_sf};         end

%% filter
do_filter  = (i_sf ~= nb_sf);
min_filter = str2double(get(obj.obj.filter.objects.minedit,'String'));
max_filter = str2double(get(obj.obj.filter.objects.maxedit,'String'));
obj.assert(~do_filter || ~isempty(min_filter), 'filter min not valid');
obj.assert(~do_filter || ~isempty(max_filter), 'filter max not valid');

%% return
if strcmp(ss_sdata,' '), obj.warning('no sdata selected');  return; end
if strcmp(ss_x    ,' '), obj.warning('no x selected');      return; end
if strcmp(ss_y    ,' '), obj.warning('no y selected');      return; end
if strcmp(ss_f    ,' '), obj.warning('no filter selected'); return; end

%% values
% x
x = evalin('base',sprintf('%s.%s;',ss_sdata,ss_x));
x = x(:);
% y
y = evalin('base',sprintf('%s.%s;',ss_sdata,ss_y));
if (size(y,2)==length(x)), y = y'; end

% filter
if do_filter
    f = evalin('base',sprintf('%s.%s;',ss_sdata,ss_f));
    f = f(:);
end

%% assert
assert(size(y,1)==length(x) || size(y,2)==length(x),'analysis: error. vectors have different length');
if do_filter
    assert(length(f)==length(x),                        'analysis: error. filter has a different length');
end

%% statistics

% x values
u_x  = unique(x);
u_x  = u_x(:);
nb_x = length(u_x);
l_x  = length(x);

% y values
m_y = nan(nb_x,1);
e_y = nan(nb_x,1);

% mean / ste
for i = 1:nb_x
    ii_x      = (x == u_x(i));
    if do_filter,   ii_f = (f >= min_filter & f <= max_filter);
    else            ii_f = true(size(ii_x));
    end
    m_y(i)  = nanmean(y(ii_x & ii_f,:));
    e_y(i)  = nanste( y(ii_x & ii_f,:));
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


%% colour
u_colour = get(obj.gfx.colour.objects.list,'String');
i_colour = get(obj.gfx.colour.objects.list,'Value');
s_colour = u_colour{i_colour};

%% style
u_style = get(obj.gfx.style.objects.list,'String');
i_style = get(obj.gfx.style.objects.list,'Value');
s_style  = u_style{i_style};

%% fig_axis
sa = struct();
% title
sa.title   = get(obj.gfx.axis.objects.title,'String');
if iscell(sa.title), sa.title = sa.title{1}; end
% tick
sa.xtick   = get(obj.gfx.axis.objects.xtick,'String');
if iscell(sa.xtick), sa.xtick = sa.xtick{1}; end
if isempty(strtrim(sa.xtick)),  sa = rmfield(sa,'xtick');
else                            sa.xtick = eval(sa.xtick);
end
sa.ytick   = get(obj.gfx.axis.objects.ytick,'String');
if iscell(sa.ytick), sa.ytick = sa.ytick{1}; end
if isempty(strtrim(sa.ytick)),  sa = rmfield(sa,'ytick');
else                            sa.ytick = eval(sa.ytick);
end
% ticklabel
sa.xticklabel = get(obj.gfx.axis.objects.xticklabel,'String');
if iscell(sa.xticklabel), sa.xticklabel = sa.xticklabel{1}; end
if isempty(strtrim(sa.xticklabel)), sa = rmfield(sa,'xticklabel');
else                                sa.xticklabel = eval(sa.xticklabel);
end
sa.yticklabel   = get(obj.gfx.axis.objects.yticklabel,'String');
if iscell(sa.yticklabel), sa.yticklabel = sa.yticklabel{1}; end
if isempty(strtrim(sa.yticklabel)), sa = rmfield(sa,'yticklabel');
else                                sa.yticklabel = eval(sa.yticklabel);
end
% grid
u_grid   = {'off','on'};
sa.xgrid = u_grid{get(obj.gfx.axis.objects.xgrid,'Value')};
sa.ygrid = u_grid{get(obj.gfx.axis.objects.ygrid,'Value')};
% lim
sa.xlim   = get(obj.gfx.axis.objects.xlim,'String');
if iscell(sa.xlim), sa.xlim = sa.xlim{1}; end
if isempty(strtrim(sa.xlim)),   sa = rmfield(sa,'xlim');
else                            sa.xlim = eval(sa.xlim);
end
sa.ylim   = get(obj.gfx.axis.objects.ylim,'String');
if iscell(sa.ylim), sa.ylim = sa.ylim{1}; end
if isempty(strtrim(sa.ylim)),   sa = rmfield(sa,'ylim');
else                            sa.ylim = eval(sa.ylim);
end
% label
sa.xlabel  = get(obj.gfx.axis.objects.xlabel,'String');
sa.ylabel  = get(obj.gfx.axis.objects.ylabel,'String');

%% plot
switch(s_style)
    case 'scatter'
        plot(u_x,m_y,   'Marker',           '.', ...
                        'LineStyle',        'none', ...
                        'MarkerEdgeColor',  fig_color(s_colour,1));
    case 'plot'
        plot(u_x,m_y,   'Marker',           'none', ...
                        'LineStyle',        '-', ...
                        'Color',            fig_color(s_colour,1));
    case 'fig_plot'
        fig_plot(u_x,m_y,fig_color(s_colour,1));
    case 'fig_steplot'
        fig_steplot(u_x,m_y,e_y,fig_color(s_colour,1));
    case 'fig_spline'
        fig_steplot(u_x,m_y,e_y,fig_color(s_colour,1));
    case 'fig_bare'
        m_y = m_y';
        e_y = e_y';
        web = fig_bare(m_y,e_y,s_colour,[],num2leg(u_x));
    otherwise
        obj.error(sprintf('unknown style "%s"',s_style));
        return;

end

%% fig_axis
fig_axis(sa);

%% fig_figure
fig_figure(gcf());
