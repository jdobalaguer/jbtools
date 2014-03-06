
function hdl = fig_plot(varargin)
    %% hdl = fig_plot([x,]my,sy[,c][,a])
    %
    % splines plot with nan standard error shade
    %
    
    %% map inputs
    if isempty(varargin);   error('fig_plot: error. no input.'); end
    if length(varargin)==1; error('fig_plot: error. fig_plot(my,sy).'); end
    if length(varargin)==2
        my = varargin{1};
        sy = varargin{2};
    else
        x = varargin{1};
        my = varargin{2};
        sy = varargin{3};
        if length(varargin)>=4; c = varargin{4}; end
        if length(varargin)>=5; c = varargin{5}; end
    end
        
    %% default
    if ~exist('x','var')||isempty(x); x=1:size(my,2); end
    if ~exist('c','var')||isempty(c); c='b'; end
    if ~exist('a','var')||isempty(a); a=0.15; end
    
    %% asserts
    assert(size(x,2)==size(my,2));
    assert(size(x,2)==size(sy,2));
    
    %% variables
    [xx,sb] = get_spline(x,my-sy);
    [xx,su] = get_spline(x,my+sy);
    
    %% plot
    hold on;
    hdl = struct();
    hdl.shade = plot_shade(xx,sb,su,c,a);
    hdl.line  = plot_spline(x,my,c);
end

%% statistics
function y = nanste(x)
    sd = nanstd(x);
    n  = sqrt(sum(~isnan(x)));
    y = sd./n;
end

%% spline
function hdl = plot_spline(x,y,c)
    [xx,yy] = get_spline(x,y);
    hdl = plot(xx,yy,'color',c,'linewidth',2);
end

function [xx,yy] = get_spline(x,y)
    s = cubic_spline(x,y);
    [xx,yy] = get_cubic_spline(x,s);
end

function s = cubic_spline(x,y)
    if size(x,1)==1; x=x'; end
    if size(y,1)==1; y=y'; end
    if any(size(x)~=size(y)) || size(x,2) ~= 1
       error('inputs x and y must be column vectors of equal length');
    end
    n = length(x);
    h = x(2:n) - x(1:n-1);
    d = (y(2:n) - y(1:n-1))./h;
    lower = h(1:end-1);
    main  = 2*(h(1:end-1) + h(2:end));
    upper = h(2:end);
    T = spdiags([lower main upper], [-1 0 1], n-2, n-2);
    rhs = 6*(d(2:end)-d(1:end-1));
    m = T\rhs;
    m = [ 0; m; 0];
    s.s0 = y;
    s.s1 = d - h.*(2*m(1:end-1) + m(2:end))/6;
    s.s2 = m/2;
    s.s3 =(m(2:end)-m(1:end-1))./(6*h);
end

function [xx,yy] = get_cubic_spline(x,s,res)
    if ~exist('res','var')||isempty(res); res = 20; end
    n = length(x);
    xx = nan(1,res*(n-1));
    yy = nan(1,res*(n-1));
    for i=1:n-1
        ii = (res*(i-1)+1):res*i;
        xx(ii) = linspace(x(i),x(i+1),res);
        xi = repmat(x(i),1,res);
        yy(ii) = s.s0(i) + s.s1(i)*(xx(ii)-xi) + s.s2(i)*(xx(ii)-xi).^2 + s.s3(i)*(xx(ii) - xi).^3;
    end
end

%% std shade
function hdl = plot_shade(x,s1,s2,c,a)
    sx = [x,fliplr(x)];
    sy = [s1 fliplr(s2)];
    if ischar(c); c = fig_color(c)./255; end
    %sc = (1-a).*ones(1,3) + a.*c;
    %hdl = fill(sx,sy,sc,'linestyle','none');
    hdl = fill(sx,sy,c,'linestyle','none','facealpha',a);
end