
function [d3,response] = d3_func(d3,request)
    %% [d3,response] = D3_FUNC(request,web)
    % d3 response for a particular request
    
    %% warnings
    
    %% function
    switch(request.Get.Filename)

        % default function
        case '/'
            d3_index(request,d3.opts);
            html = d3_index(request,d3.opts);
            response = struct('html',html,'header',header2text(make_html_http_header(html,true)));

        % stop webserver
        case {'/end','/end.html'}
            request.Get.Filename = '/end.html';
            [d3,response] = web_func(d3,request);
            d3 = d3_close(d3);

        % normal behaviour
        otherwise
            [d3,response] = web_func(d3,request);
    end
    
end