
function varargout = webserver_run(file,varargin)
    %% {varargout} = D3_FUNC(file,varargin1,varargin2,..)
    % private function. run web-server functions
    % see also d3_help
    
    %% function
    [varargout{1:nargout}] = func_run(fullfile(d3_root,'private','webserver',file),varargin);
end
