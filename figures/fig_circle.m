
function h = fig_circle(varargin)
    %% h = FIG_CIRCLE(x,y,rx,ry,...)
    % plot a circle
    
    %% function
    
    % default
    varargin(end+1:5) = {[]};
    cx = varargin{1};
    cy = varargin{2};
    rx = varargin{3};
    ry = varargin{4};
    
    % coordinates
    n = 50;
    t = linspace(0,2*pi,n+1);
    px = cx + rx .* cos(t);
    py = cy + ry .* sin(t);
    
    % plot line
    h = plot(px,py,'marker','none',varargin{5:end});
end
