
function varargout = func_deal(varargin)
    %% v1[,v2][,..] = FUNC_DEAL(v1,[,v2][,..])
    % copy values from a cell to many variables.
    % if the number of inputs/outputs does not match,
    % inputs are ignored and outputs are assigned with [].
    
    %% function
    ux = varargin;
    if iscell(ux) && isscalar(ux), ux = ux{1}; end
    nx = length(ux);
    varargout = cell(1,max(nx,nargout));
    varargout(1:nx) = ux;
    varargout = varargout(1:nargout);
end
