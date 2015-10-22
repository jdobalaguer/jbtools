
function d3_example(varargin)
    %% D3_EXAMPLE([pars,vals,])
    % open a figure with d3
    % see also d3_data
    %          d3_figure
    %          d3_example

    %% warnings
    %#ok<>
    
    %% function
    
    t1 = linspace(0,02*pi, 10);
    t2 = linspace(0,12*pi, 50);
    y1 = sin(t1);
    y2 = cos(t2);
    data    = d3_data();
    data(1) = d3_data(1,'plot',t1,y1,'axis_rng_y',[-1,+1]);
    data(2) = d3_data(2,'plot',t2,y2,'axis_rng_y',[-1,+1]);
    data(3) = d3_data(1,'plot',t1,y1,'styl_interp','basis');
    data(4) = d3_data(2,'plot',t2,y2,'styl_interp','basis');
    
    d3_figure(data,varargin{:});
    
end