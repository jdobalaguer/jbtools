
function d3_figure(varargin)
    %% D3_FIGURE(data,[pars,vals,])
    % open a figure with d3

    %% warnings
    %#ok<*UNRCH>
    
    %% function
    d3 = d3_start(varargin{:});
    while(d3.TCP.socket ~= -1)
        d3 = web_reply(d3);
    end
    
end