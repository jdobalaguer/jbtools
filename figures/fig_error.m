
function h = fig_error(varargin)
    %% h = FIG_ERROR([x,]my,sy[,c])
    % plot error bars
    % x  : x-values
    % my : center of y-value of the error
    % sy : half-height of the error
    % c  : color of the error
    % h  : handle of the error
    
    %% function
    
    assert(nargin>2, 'fig_error: error. not enough arguments');
    
    % default
    varargin(end+1:4) = {[]};
    [x,my,sy,c] = deal(varargin{1:4});
    my = mat2row(my);
    func_default('x',1:length(my));
    func_default('sy',zeros(size(my)));
    func_default('c','b');
    if ischar(c); c = fig_color(c,1); end
    
    % assert
    assertSize(x,my,sy);
    
    % plot
    h = errorbar(x,my,-sy,+sy,'Color',c,'linestyle','none',varargin{5:end});
end
