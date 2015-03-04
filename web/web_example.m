
function web_example(varargin)
    %% WEB_EXAMPLE([pars,vals])
    % example on how to use the web toolkit
    % see also web_start
    %          web_close
    %          web_default
    %          web_reply
    %          web_browser

    %% warnings
    %#ok<*UNRCH>
    
    %% function
    web = web_start(varargin{:});
    web_browser(sprintf('http://localhost:%d/',web.opts.port));
    while(true)
        web = web_reply(web);
    end
    web = web_close(web);
end