
function h = fig_marker(varargin)
    %% h = FIG_MARKER([x,]my[,c])
    % plot markers
    % x  : x-values
    % my : center of y-value of the error
    % c  : color
    % h  : handle
    
    %% function
    
    assert(nargin>1, 'fig_marker: error. not enough arguments');
    
    % default
    varargin(end+1:3) = {[]};
    [x,y,c] = deal(varargin{1:3});
    x = mat2row(x);
    y = mat2row(y);
    func_default('x',1:length(y));
    func_default('c','b');
    if ischar(c); c = fig_color(c,1); end
    
    % assert
    assertSize(x,y);
    
    % plot
    h = plot(x,y,'color',c,'marker','.','markersize',20,'linestyle','none','linewidth',2,varargin{4:end});
end
