
function defs = d3_start_default()
    %% defs = D3_START_DEFAULT()
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
    defs.port           = 4000;
    defs.www_folder     = [jbtools_root,'/d3/private/www'];
    defs.temp_folder    = [jbtools_root,'/d3/private/www/temp'];
    defs.verbose        = false;
    defs.defaultfile    = '/m/d3_html.m';
    defs.defaultnone    = '/html/404.html';
    defs.defaulterr     = '/m/d3_error.m';
    defs.mtime1         = 0;
    defs.mtime2         = 3;
    defs.timeout        = 1000;
    defs.data           = [];
end