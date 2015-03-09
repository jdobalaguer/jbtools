
function d3_example2(varargin)
    %% D3_EXAMPLE2([pars,vals,])
    % open a figure with d3
    % see also d3_data
    %          d3_figure
    %          d3_example

    %% warnings
    %#ok<*AGROW>
    
    %% function
    
    data = d3_data();
    for i = 1:20
        t = linspace(0,2*pi,i);
        y = sin(t);
        data(end+1) = d3_data(1,'plot',t,y,'axis_rng_y',[-1,+1],'styl_interp','linear'); 
    end
    
    d3_figure(data,varargin{:});
    
end