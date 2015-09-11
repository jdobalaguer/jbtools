
function varargout = func_run(file,args)
    %% ret = FUNC_RUN(path,args)
    % run a function/script in [path] with arguments [args]
    % if you want to save the output, use FUNC_HANDLE directly.
    
    %% function
    
    % default
    func_default('args',{});
    if ~iscell(args), args = {args}; end
    varargout = {};
    
    % no input / no output (func or script)
    if ~nargout && isempty(args)
        evalin('base',sprintf('run(''%s'');',file));
        return;
    end
    
    % get handle
    func = func_handle(file);
    
    % run function
    varargout = func_return(func,nargout,args{:});
    
end