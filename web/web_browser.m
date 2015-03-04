
function web_browser(url)
    %% WEB_BROWSER([url])
    % opens a web browser on the specified url
    % see also web_start
    %          web_close
    %          web_default
    %          web_reply
    %          web_example
    
    %% warnings
    
    %% function
    
    % defaults
    if ~exist('url','var'), url = ''; end
    
    % Open a browser
    cmd = sprintf('open "%s"',url);
    unix(cmd);
    
end