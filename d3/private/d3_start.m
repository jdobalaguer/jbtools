
function d3 = d3_start(varargin)
    %% D3_START(data,[opt])
    % D3_START(data[,par1,val1][,par2,val2])
    % private function. initialise the webserver
    % see also d3_help
    
    %% function
    
    % Options
    if isscalar(varargin) && isstruct(varargin{1}), opts = varargin{1};
    else opts = pair2struct(varargin);
    end
    
    % Config of the HTTP server
    defs = d3_start_default();
    opts = struct_default(opts,defs);
    
    % Open a TCP Server Port
    TCP = webserver_run('JavaTcpServer','initialize',[],[],opts);
    opts.port = TCP.port;
    d3  = struct('TCP',TCP,'opts',opts);
end