
function o = glm_options()
    %% o = GLM_OPTIONS()
    % Default options for the glm toolbox
    % 
    % o : struct : template with default options

    %% function
    o = struct();
    o.dist     = 'normal';
    o.link     = 'identity';
    o.constant = 'off';
end
