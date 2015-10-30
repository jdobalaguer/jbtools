
function [z,u] = getm_func(varargin)
    %% [z,u] = GETM_FUNC(f,y,x1[,x2][,x3][...])
    % apply function to the vector extracted from each combination of conditions
    % save a scalar value per combination
    
    %% function
    [z,u] = getm_all(varargin{2:end});
    z = cellfun(varargin{1},z);
end
