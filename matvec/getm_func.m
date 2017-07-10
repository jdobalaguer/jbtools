
function [z,u] = getm_func(varargin)
    %% [z,u] = GETM_FUNC(f,y,x1[,x2][,x3][...])
    % apply function to the vector extracted from each combination of conditions
    % save a scalar value per combination
    
    %% function
    [z,u] = getm_all(varargin{2:end});
    s = [mat_size(z),size(varargin{2},2)];
    z = cellfun(varargin{1},z,'UniformOutput',false);
    z = cat(1,z{:});
    z = mat_reshape(z,s);
end
