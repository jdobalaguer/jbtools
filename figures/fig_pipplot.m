
function hdl = fig_pipplot(varargin)
    %% hdl = fig_steplot([x,]my,sy[,c])
    % plot with nan standard error pips
    
    %% function
    
    % default
    if nargin == 2
        [my,sy] = deal(varargin{1:2});
        [x,c,a] = deal(1:length(my),'b',0.15);
    else
        varargin(end+1:5) = {[]};
        [x,my,sy,c,a] = deal(varargin{1:5});
    end
    
    % assert
    assertSize(x,my,sy);
    
    % variables
    sb = my-sy;
    su = my+sy;
    
    % plot
    hold('on');
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