
function h = fig_exy(varargin)
    %% h = FIG_EXY(mode,mx,my,sx,sy[,c][,a])
    % plot error bars for X and Y
    % mode : plot style, a cell including some of {'line','pip','shade','error'}
    % mx   : center of x-values
    % my   : center of y-value
    % ss   : half-height of x-width
    % sy   : half-height of y-height
    % c    : color
    % a    : alpha
    % h    : handles of the plot
    
    %% function
    
    assert(nargin>2, 'fig_exy: error. not enough arguments');
    
    % default
    varargin(end+1:7) = {[]};
    [mode,mx,my,sx,sy,c,a] = deal(varargin{1:7});
    mx = mat2row(mx);
    my = mat2row(my);
    sx = mat2row(sx);
    sy = mat2row(sy);
    func_default('mode',{'pip','shade'});
    func_default('c','b');
    func_default('a',0.15);
    if ischar(c); c = fig_color(c,1); end
    
    % assert
    assertClass(mode,{'char','cell'});
    assertSize(mx,my,sx,sy);
    
    % cell mode
    if iscellstr(mode)
        h = struct();
        h.(mode{1}) = fig_exy(mode{1},mx,my,sx,sy,c,a);
        for i_mode = 2:length(mode)
            hold('on');
            h.(mode{i_mode}) = fig_exy(mode{i_mode},mx,my,sx,sy,c,a);
        end
        return;
    end
    
    % plot
    switch mode
        case 'line',
            hold('on');
            h = arrayfun(@(mx,my,sx,sy)fig_circle(mx,my,sx,sy,'Color',c,'LineStyle','--'),mx,my,sx,sy,'UniformOutput',false);
            h = [h{:}];
        case 'marker'
            h = fig_combination('marker',mx,my,sy,c,a);
        case 'pip'
            hold('on');
            h = arrayfun(@(mx,my,sx,sy)fig_circle(mx,my,sx,sy,'Color',c,'LineStyle','--'),mx,my,sx,sy,'UniformOutput',false);
            h = [h{:}];
        case 'error'
            hold('on');
            h.x = arrayfun(@(mx,my,sx,sy) plot(mx+[-sx,+sx],[my,my],'Color',c),mx,my,sx,sy,'UniformOutput',false);
            h.x = [h.x{:}];
            h.y = arrayfun(@(mx,my,sx,sy) plot([mx,mx],my+[-sy,+sy],'Color',c),mx,my,sx,sy,'UniformOutput',false);
            h.y = [h.y{:}];
        case 'shade'
            hold('on');
            h = arrayfun(@(mx,my,sx,sy)fig_circle_shade(mx,my,sx,sy,c,[]),mx,my,sx,sy,'UniformOutput',false);
            h = [h{:}];
    end
end
