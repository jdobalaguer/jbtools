
function varargout = fig_polyfit(x,y,n,x0,varargin)
    %% h = FIG_POLYFIT(x,y[,n][,x0][,varargin])
    % plot a polynomial approximation
    % (x,y) : data to approximate
    % n     : polynomial order (default 1)
    % x0    : points to plot   (default x)
    
    %% function
    varargout = {};
    
    % default
    func_default('n',1);
    func_default('x0',sort(x));
    assertSize(x,y);
    assertVector(x,y);
    
    % remove nans
    ii = ~any(isnan([x(:),y(:)]),2);
    x = x(ii);
    y = y(ii);
    
    % polynomial fitting/evaluation
    p  = polyfit(x,y,n);
    y0 = polyval(p,x0);
    
    % plot
    h = plot(x0,y0,'',varargin{:});
    
    if nargout
        varargout = {h};
    end
end
