
function h = fig_arrow(varargin)
    %% h = FIG_ARROW(x,y,...)
    % plot an arrow
    
    %% warnings
    
    %% function
    x = varargin{1};
    y = varargin{2};
    dx = x(2)-x(1);
    dy = y(2)-y(1);
%     h = quiver(x(1),y(1),dx,dy,'maxheadsize',0.5,varargin{3:end});
    h = quiver(x(1),y(1),dx,dy,varargin{3:end});
    
end