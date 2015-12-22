
function h = fig_circle_shade(varargin)
    %% h = FIG_CIRCLE(x,y,rx,ry,c,a,...)
    % plot a circle shade
    
    %% function
    
    % default
    varargin(end+1:6) = {[]};
    cx = varargin{1};
    cy = varargin{2};
    rx = varargin{3};
    ry = varargin{4};
    c  = varargin{5};
    a  = varargin{6};
    func_default('c','b');
    func_default('a',0.15);
    if ischar(c); c = fig_color(c,1); end
    
    % coordinates
    n = 50;
    t = linspace(0,2*pi,n+1);
    px = cx + rx .* cos(t);
    py = cy + ry .* sin(t);
    
    % plot shade
    if ~a, return; end
    h = fill(px,py,c,'linestyle','none','facealpha',a,varargin{7:end});
end
