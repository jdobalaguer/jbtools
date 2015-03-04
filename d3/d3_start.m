
function d3 = d3_start(varargin)
    %% d3 = D3_START(data,[pars,vals,])
    
    %% warnings
    
    %% function
    
    % parse varargin
    defs = web_default();
    defs.www_folder  = [jbtools_root,'/d3/private/www'];
    defs.temp_folder = '';
    defs.defaultfunc = @d3_func;
    opts = parser(varargin(2:end),defs);
    opts.extra = varargin{1};
    
    % start webserver
    d3 = web_start(opts);
    
    % open browser
    web_browser(sprintf('http://localhost:%d/',d3.opts.port));
    
end
