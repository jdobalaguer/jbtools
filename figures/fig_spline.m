
function h = fig_spline(varargin)
    %% h = fig_spline(mode,[x,]my,sy[,c][,a])
    % plot whatever using splines
    % mode : what kind of plot. a string or a cell of strings. one or more of {'line','pip','error','shade'}
    % x    : x-values
    % my   : center of y-value
    % sy   : half-height of area
    % c    : color
    % a    : alpha
    % h    : handle of the plot
    
    %% function
    
    assert(nargin>2, 'fig_spline: error. not enough arguments');
    
    % default
    varargin(end+1:6) = {[]};
    [mode,x,my,sy,c,a] = deal(varargin{1:6});
    my = mat2row(my);
    func_default('mode','line');
    func_default('x',1:length(my));
    func_default('sy',zeros(size(my)));
    func_default('c','b');
    func_default('a',0.15);
    if ischar(c); c = fig_color(c,1); end
    
    % assert
    assertClass(mode,{'char','cell'});
    assertSize(x,my,sy);
    assertVector(x,my,sy);
    
    % variables
    if numel(x) > 1
        [xx,sb] = get_spline(x,my-sy);
        [~ ,su] = get_spline(x,my+sy);
        mm = 0.5 * (su+sb);
        ss = 0.5 * (su-sb);
    else
        [xx,mm,ss] = deal(x,my,sy);
    end
    
    % hold on
    if iscellstr(mode) && length(mode)>1
        hold('on');
    end
    
    % plot
    if any(strcmp(mode,'line')),    h.line   = fig_line  (xx,mm,c,varargin{7:end});      end
    if any(strcmp(mode,'marker')),  h.marker = fig_marker(xx,mm,c,varargin{7:end});      end
    if any(strcmp(mode,'pip')),     h.pip    = fig_pip   (xx,mm,ss,c,varargin{7:end});   end
    if any(strcmp(mode,'error')),   h.error  = fig_error (xx,mm,ss,c,varargin{7:end});   end
    if any(strcmp(mode,'shade')),   h.shade  = fig_shade (xx,mm,ss,c,a,varargin{7:end}); end
end

%% auxiliar

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
