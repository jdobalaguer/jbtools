
function d3 = d3_reply(d3)
    %% d3_REPLY(web)
    % replies to one request in the queue
    % see also d3_start
    %          d3_default
    %          d3_close
    %          d3_reply
    %          d3_browser
    %          d3_figure
    %          d3_example
    
    %% warnings
    %#ok<>
    
    %% function
    
    % Wait for connections of browsers
    d3.TCP = JavaTcpServer('accept',d3.TCP,[],d3.opts);

    % Read the data from the browser
    [d3.TCP,requestdata] = JavaTcpServer('read',d3.TCP,[],d3.opts);
    if(isempty(requestdata)), return; end
    request = text2header(requestdata,d3.opts);
    
    % Call a function
    switch(request.Get.Filename)
        case {'/end','/end.html'}
            % stop webserver
            request.Get.Filename = '/html/end.html';
            [d3,response] = d3_func(d3,request);
            d3 = d3_close(d3);
        otherwise
            % normal behaviour
            [d3,response] = d3_func(d3,request);
    end
    
    % Give the generated HTML or binary code back to the browser
    JavaTcpServer('write',d3.TCP,int8(response.header),d3.opts);
    JavaTcpServer('write',d3.TCP,int8(response.html),  d3.opts);
    
end