
function d3_figure(varargin)
    %% D3_FIGURE(data,[pars,vals,])
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
    d3 = d3_start(varargin{2:end});
    [d3.opts.data,d3.opts.summ] = d3_summ(varargin{1});
    d3_browser(sprintf('localhost:%d/',d3.opts.port));
    while(d3.TCP.socket ~= -1)
        d3 = d3_reply(d3);
    end
    
end