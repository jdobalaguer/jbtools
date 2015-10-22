
function defs = d3_start_default()
    %% defs = D3_START_DEFAULT()
    % private function. default configuration for the web-server
    % see also d3_help
    
    %% function
    defs = struct();
    defs.port           = 4000;
    defs.www_folder     = file_endsep(fullfile(d3_root,'private','www'));
    defs.temp_folder    = file_endsep(fullfile(d3_root,'private','www','temp'));
    defs.verbose        = false;
    defs.defaultfile    = fullfile('m','d3_html.m');
    defs.defaultnone    = fullfile('html','404.html');
    defs.defaulterr     = fullfile('m','d3_error.m');
    defs.mtime1         = 0;
    defs.mtime2         = 3;
    defs.timeout        = 1000;
    defs.data           = [];
end
