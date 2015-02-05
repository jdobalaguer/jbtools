function hdl = fig_4d(m,t,xtick,ytick,ztick,xlabel,ylabel,zlabel)
    %% [hdl] = FIG_4D(m,a,xtick,ytick,ztick,xlabel,ylabel,zlabel)
    % display 4-dimensional data as a transparent cube
    % originally writen by santiago
    % [m]     = data matrix
    % [t]     = opacity threshold
    % [tick]  = axis range/scale
    % [label] = axis label

    %% default
    if ~exist('t','var'),      t      = 0; end
    if ~exist('xtick','var'),  xtick  = 1:size(m,1); end
    if ~exist('ytick','var'),  ytick  = 1:size(m,2); end
    if ~exist('ztick','var'),  ztick  = 1:size(m,3); end
    if ~exist('xlabel','var'), xlabel = 'X'; end
    if ~exist('ylabel','var'), ylabel = 'Y'; end
    if ~exist('zlabel','var'), zlabel = 'Z'; end
    
    %% assert
    assert(ndims(m)==3,             'fig_4d: error. [m] is not 3-dimensional.');
    assert(length(xtick)==size(m,1),'fig_4d: error. inconsistent [xtick].');
    assert(length(ytick)==size(m,2),'fig_4d: error. inconsistent [ytick].');
    assert(length(ztick)==size(m,3),'fig_4d: error. inconsistent [ztick].');
    assert(ischar(xlabel),          'fig_4d: error. [xlabel] not a string.');
    assert(ischar(ylabel),          'fig_4d: error. [ylabel] not a string.');
    assert(ischar(zlabel),          'fig_4d: error. [zlabel] not a string.');
    
    %% function
    
    % xticks
    i_x = 1:size(m,1);
    i_y = 1:size(m,2);
    i_z = 1:size(m,3);
    
    % plot box
    hdl = slice(m,i_x,i_y,i_z);
    
    % alphas 
    set(hdl,'EdgeColor','none','FaceColor','interp','FaceAlpha','interp');
    alpha('color');
    alphamap('rampdown');
    alphamap('decrease',t);
    
    % camera
    view(80,10);
    camproj('orthographic'); % or 'perspective'

    % axis
    sa = struct('xtick',i_y,'xticklabel',xtick,'ytick',i_y,'yticklabel',ytick,'ztick',i_y,'zticklabel',ztick,'xlabel',xlabel,'ylabel',ylabel,'zlabel',zlabel);
    fig_axis(sa);

end