
function d3_example(varargin)
    %% D3_EXAMPLE([pars,vals,])
    % open a figure with d3
    % see also d3_start
    %          d3_defaults
    %          d3_close
    %          d3_reply
    %          d3_browser
    %          d3_figure
    %          d3_example

    %% warnings
    %#ok<*UNRCH>
    
    %% function
    n = 50;
    t = linspace(0,4*pi,n);
    y1 = sin(t);
    y2 = cos(t);
    data(1) = d3_data(1,'plot',t,y1);
    data(2) = d3_data(2,'plot',t,y2);
    d3_figure(data,varargin{:});
    
end