
function defs = web_default()
    %% defs = WEB_DEFAULT()
    % default configuration for the web-server
    % see also web_start
    %          web_close
    %          web_reply
    %          web_browser
    %          web_example
    
    %% warnings

    %% function
    defs = struct();
    defs.port           = 4000;
    defs.www_folder     = [jbtools_root,'/web/private/www'];
    defs.temp_folder    = [jbtools_root,'/web/private/www/temp'];
    defs.verbose        = false;
    defs.defaultfunc    = @web_func;
    defs.defaultfile    = '/index.m';
    defs.mtime1         = 0;
    defs.mtime2         = 3;
    defs.timeout        = 1000;
    defs.extra          = [];
end