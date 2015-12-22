
function h = fig_pip(varargin)
    %% h = FIG_PIP([x,]my,sy[,c])
    % plot pip lines
    % x  : x-values
    % my : center of y-value of the pip
    % sy : half-height of the pip
    % c  : color of the pip
    % h  : handles of the pip
    
    %% function
    
    assert(nargin>2, 'fig_pip: error. not enough arguments');
    
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
    xx = [x,fliplr(x)];         xx(end+1) = xx(1);
    yy = [my-sy,fliplr(my+sy)]; yy(end+1) = yy(1);
    h = plot(xx,yy,'color',c,'marker','none','linestyle','--',varargin{5:end});
end
