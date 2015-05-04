
function hdl = fig_errplot(varargin)
    %% hdl = fig_errplot([x,]my,sy[,c])
    %
    % splines plot with nan standard error shade
    %
    
    %% map inputs
    if isempty(varargin);   error('fig_errplot: error. no input.'); end
    if length(varargin)==1; error('fig_errplot: error. fig_errplot(my,sy).'); end
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
    hdl.errbar = plot_errorbar(x,my,sy,c);
end

%% plot
function hdl = plot_errorbar(x,my,sy,c)
    if ischar(c); c = fig_color(c,1); end
    hdl = errorbar(x,my,-sy,+sy,'Color',c,'linewidth',2);
end