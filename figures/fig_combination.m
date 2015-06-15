
function h = fig_combination(varargin)
    %% h = FIG_COMBINATION(mode,[x,]my,sy[,c][,a])
    % plot whatever using splines
    % mode : what kind of plot. a string or a cell of strings. one or more of {'line','pip','error','shade'}
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
    my = mat2row(my);
    func_default('mode','line');
    func_default('x',1:length(my));
    func_default('sy',zeros(size(my)));
    func_default('c','b');
    func_default('a',0.15);
    if ischar(c); c = fig_color(c,1); end
    
    % assert
    assertClass(mode,{'char','cell'});
    assertSize(x,my,sy);
    
    % hold on
    if iscellstr(mode) && length(mode)>1
        hold('on');
    end
    
    % plot
    if any(strcmp(mode,'line')),    fig_line(x,my,c,varargin{7:end});       end
    if any(strcmp(mode,'marker')),  fig_marker(x,my,c,varargin{7:end});     end
    if any(strcmp(mode,'pip')),     fig_pip(x,my,sy,c,varargin{7:end});     end
    if any(strcmp(mode,'error')),   fig_error(x,my,sy,c,varargin{7:end});   end
    if any(strcmp(mode,'shade')),   fig_shade(x,my,sy,c,a,varargin{7:end}); end
end
