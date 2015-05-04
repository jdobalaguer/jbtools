
function hdl = fig_steplot(varargin)
    %% hdl = fig_steplot([x,]my,sy[,c][,a])
    %
    % splines plot with nan standard error shade
    %
    
    %% map inputs
    if isempty(varargin);   error('fig_steplot: error. no input.'); end
    if length(varargin)==1; error('fig_steplot: error. fig_steplot(my,sy).'); end
    if length(varargin)==2
        my = varargin{1};
        sy = varargin{2};
    else
        x = varargin{1};
        my = varargin{2};
        sy = varargin{3};
        if length(varargin)>=4; c = varargin{4}; end
        if length(varargin)>=5; a = varargin{5}; end
    end
    
    %% default
    if ~exist('x','var')||isempty(x); x=1:size(my,2); end
    if ~exist('c','var')||isempty(c); c='b'; end
    if ~exist('a','var')||isempty(a); a=0.15; end
        
    %% asserts
    assert(size(x,2)==size(my,2),'x and my must have same number of columns');
    assert(size(x,2)==size(sy,2),'x and sy must have same number of columns');
    
    %% variables
    sb = my-sy;
    su = my+sy;
    
    %% plot
    hold on;
    hdl = struct();
    hdl.shade = plot_shade(x,sb,su,c,a);
    hdl.line  = plot_line(x,my,c);
end

%% plot
function hdl = plot_line(x,y,c)
    hdl = plot(x,y,'color',c,'linewidth',2);
end

function hdl = plot_shade(x,s1,s2,c,a)
    x  = mat2vec(x)';
    s1 = mat2vec(s1)';
    s2 = mat2vec(s2)';
    sx = [x  ,  fliplr(x)];
    sy = [s1 ,  fliplr(s2)];
    if ischar(c); c = fig_color(c,1); end
    %sc = (1-a).*ones(1,3) + a.*c;
    %hdl = fill(sx,sy,sc,'linestyle','none');
    hdl = fill(sx,sy,c,'linestyle','none','facealpha',a);
end