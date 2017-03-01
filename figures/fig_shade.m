
function h = fig_shade(varargin)
    %% h = FIG_SHADE([x,]my,sy[,c][,a])
    % plot a shade
    % x  : x-values
    % my : center of y-value of the shade
    % sy : half-height of the shade
    % c  : color of the shade
    % a  : alpha of the shade
    % h  : handle of the shade
    
    %% function
    
    assert(nargin>2, 'fig_shade: error. not enough arguments');
    
    % default
    varargin(end+1:5) = {[]};
    [x,my,sy,c,a] = deal(varargin{1:5});
    x  = mat2row(x);
    my = mat2row(my);
    sy = mat2row(sy);
    func_default('x',1:length(my));
    func_default('sy',zeros(size(my)));
    func_default('c','b');
    func_default('a',0.15);
    if ischar(c); c = fig_color(c,1); end
    
    % assert
    assertSize(x,my,sy);
    
    % plot
    xx = [x,fliplr(x)];
    yy = [my-sy,fliplr(my+sy)];
    h = fill(xx,yy,c,'linestyle','none','facealpha',a,varargin{6:end});
end
