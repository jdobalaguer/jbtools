
function h = fig_combination(varargin)
    %% h = FIG_COMBINATION(mode,[x,]my,sy[,c][,a])
    % plot whatever using standard error
    % mode : what kind of plot. a string or a cell of strings. one or more of {'line','pip','error','shade','marker'}
    % x    : x-values
    % my   : center of y-value
    % sy   : half-height of area
    % c    : color
    % a    : alpha
    % h    : handle of the plot
    
    %% function
    
    assert(nargin>2, 'fig_combination: error. not enough arguments');
    
    % default
    varargin(end+1:6) = {[]};
    [mode,x,my,sy,c,a] = deal(varargin{1:6});
    x  = mat2row(x);
    my = mat2row(my);
    sy = mat2row(sy);
    func_default('mode',{'line','pip','shade','marker'});
    func_default('x',1:length(my));
    func_default('sy',zeros(size(my)));
    func_default('c','b');
    func_default('a',0.15);
    if ischar(c); c = fig_color(c,1); end
    
    % assert
    assertClass(mode,{'char','cell'});
    assertSize(x,my,sy);
    
    % cell mode
    if iscellstr(mode)
        h = struct();
        h.(mode{1}) = fig_combination(mode{1},x,my,sy,c,a,varargin{7:end});
        for i_mode = 2:length(mode)
            hold('on');
            h.(mode{i_mode}) = fig_combination(mode{i_mode},x,my,sy,c,a,varargin{7:end});
        end
        return;
    end
    
    % plot
    switch mode
        case 'line',    h = fig_line(x,my,c,varargin{7:end});
        case 'marker',  h = fig_marker(x,my,c,varargin{7:end});
        case 'pip',     h = fig_pip(x,my,sy,c,varargin{7:end});
        case 'error',   h = fig_error(x,my,sy,c,varargin{7:end});
        case 'shade',   h = fig_shade(x,my,sy,c,a,varargin{7:end});
    end
end
