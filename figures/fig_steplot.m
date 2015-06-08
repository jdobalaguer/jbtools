
function hdl = fig_steplot(varargin)
    %% hdl = fig_steplot([x,]my,sy[,c][,a])
    % plot with nan standard error shade
    
    %% function
    
    % mapping
    if nargin == 2
        [my,sy] = deal(varargin{1:2});
    else
        varargin(end+1:5) = {[]};
        [x,my,sy,c,a] = deal(varargin{1:5});
    end
    
    % default
    func_default('x',1:length(my));
    func_default('c','b');
    func_default('a',0.15);
        
    % assert
    assertSize(x,my,sy);
    
    % variables
    sb = my-sy;
    su = my+sy;
    
    % plot
    hold('on');
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