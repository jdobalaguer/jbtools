
function web = web_reply(web)
    %% WEB_REPLY(web)
    % replies to one request in the queue
    % see also web_start
    %          web_close
    %          web_default
    %          web_browser
    %          web_example
    
    %% warnings
    
    %% function
    
    % Wait for connections of browsers
    web.TCP = JavaTcpServer('accept',web.TCP,[],web.opts);

    % Read the data from the browser
    [web.TCP,requestdata] = JavaTcpServer('read',web.TCP,[],web.opts);
    if(isempty(requestdata)), return; end
    request = text2header(requestdata,web.opts);
    
    % Call a function
    [web,response] = web.opts.defaultfunc(web,request);
    
    % Give the generated HTML or binary code back to the browser
    JavaTcpServer('write',web.TCP,int8(response.header),web.opts);
    JavaTcpServer('write',web.TCP,int8(response.html),  web.opts);
    
end