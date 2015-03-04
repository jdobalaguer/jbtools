
function web = web_start(varargin)
    %% web = WEB_START(varargin)
    % initialize the webserver
    % see also web_close
    %          web_default
    %          web_reply
    %          web_browser
    %          web_example
    
    %% warnings
    
    %% function
    
    % Config of the HTTP server
    defs = web_default();
    opts = parser(varargin,defs);
    
    % Open a TCP Server Port
    TCP = JavaTcpServer('initialize',[],[],opts);
    web = struct('TCP',TCP,'opts',opts);
end