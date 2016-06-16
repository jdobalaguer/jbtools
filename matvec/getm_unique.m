
function [z,u] = getm_unique(varargin)
    %% [z,u] = GETM_UNIQUE(y,x1,x2,...)
    % get cell [z] with unique values per combination [u]
    
    %% function
    [z,u] = getm_all(varargin{:});
    z = cellfun(@nanunique,z,'UniformOutput',false);
end
