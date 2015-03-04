
function web = web_close(web)
    %% WEB_CLOSE(TCP)
    % see also web_start
    %          web_default
    %          web_reply
    %          web_browser
    %          web_example
    
    %% warnings
    
    %% function
    % close socket
    web.TCP = JavaTcpServer('close',web.TCP,[],[]);
end