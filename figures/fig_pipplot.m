
function hdl = fig_pipplot(varargin)
    %% hdl = fig_steplot([x,]my,sy[,c])
    % plot with nan standard error pips
    %
    
    %% map inputs
    if isempty(varargin);   error('fig_pipplot: error. no input.'); end
    if length(varargin)==1; error('fig_pipplot: error. fig_pipplot(my,sy).'); end
    if length(varargin)==2
        my = varargin{1};
        sy = varargin{2};
    else
        x = varargin{1};
        my = varargin{2};
        sy = varargin{3};
        if length(varargin)>=4; c = varargin{4}; end
    end
    
    %% default
    if ~exist('x','var')||isempty(x); x=1:size(my,2); end
    if ~exist('c','var')||isempty(c); c='b'; end
        
    %% asserts
    assert(size(x,2)==size(my,2),'x and my must have same number of columns');
    assert(size(x,2)==size(sy,2),'x and sy must have same number of columns');
    
    %% variables
    sb = my-sy;
    su = my+sy;
    
    %% plot
    hold on;
    hdl = struct();
    hdl.pip   = plot_pip(x,sb,su,c);
    hdl.line  = plot_line(x,my,c);
end

%% plot
function hdl = plot_line(x,y,c)
    hdl = plot(x,y,'color',c,'linewidth',2);
end

function hdl = plot_pip(x,s1,s2,c)
    x  = mat2vec(x)';
    s1 = mat2vec(s1)';
    s2 = mat2vec(s2)';
    if ischar(c); c = fig_color(c,1); end
    hdl(1) = plot(x,s1,'color',c,'marker','none','linestyle','--');
    hdl(2) = plot(x,s2,'color',c,'marker','none','linestyle','--');
end