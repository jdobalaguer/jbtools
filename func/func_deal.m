
function varargout = func_deal(varargin)
    %% v1[,v2][,..] = FUNC_DEAL(v1,[,v2][,..])
    % copy values from a cell to many variables.
    % if the number of inputs/outputs does not match,
    % inputs are ignored and outputs are assigned with [].
    
    %% function
    varargout = cell(1,max(nargin,nargout));
    varargout(1:nargin) = varargin;
    varargout = varargout(1:nargout);
end
