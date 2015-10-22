
function d3_figure(varargin)
    %% D3_FIGURE(data,[opt])
    % D3_FIGURE(data[,par1,val1][,par2,val2])
    % open a figure with d3
    % data : what to plot (see d3_data)
    % opt  : struct with options (alternatively, parameters and values)
    % see also d3_help
    %          d3_data
    %          d3_example

    %% warnings
    %#ok<*UNRCH>
    
    %% function
    d3 = d3_start(varargin{2:end});
    [d3.opts.data,d3.opts.summ] = d3_summ(varargin{1});
    d3_browser(sprintf('localhost:%d/',d3.opts.port));
    while(d3.TCP.socket ~= -1)
        d3 = d3_reply(d3);
    end
end
