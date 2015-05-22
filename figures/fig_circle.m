
function h = fig_circle(varargin)
    %% h = FIG_ARROW(x,y,rx,ry,...)
    % plot an arrow
    
    %% warnings
    
    %% function
    cx = varargin{1};
    cy = varargin{2};
    rx = varargin{3};
    ry = varargin{4};
    n = 50;
    t = linspace(0,2*pi,n+1);
    px = cx + rx .* cos(t);
    py = cy + ry .* sin(t);
    h = plot(px,py,'marker','none',varargin{5:end});
    
end