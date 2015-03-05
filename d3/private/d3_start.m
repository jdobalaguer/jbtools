
function d3 = d3_start(varargin)
    %% d3 = D3_START(data[,args,vals])
    % initialize the webserver
    % see also d3_start
    %          d3_start_default
    %          d3_close
    %          d3_reply
    %          d3_browser
    %          d3_figure
    %          d3_example
    
    %% warnings
    
    %% function
    
    % Config of the HTTP server
    defs = d3_start_default();
    opts = parser(varargin,defs);
    
    % Open a TCP Server Port
    TCP = JavaTcpServer('initialize',[],[],opts);
    opts.port = TCP.port;
    d3  = struct('TCP',TCP,'opts',opts);
end