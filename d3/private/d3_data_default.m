
function defs = d3_data_default()
    %% defs = D3_DATA_DEFAULT()
    % default configuration for the web-server
    % see also d3_start
    %          d3_start_default
    %          d3_close
    %          d3_reply
    %          d3_browser
    %          d3_figure
    %          d3_example
    
    %% warnings

    %% function
    defs = struct();
    defs.fig    =  1;
    defs.chart  = '';
    defs.axis   = [];
    defs.vals   = [];
end