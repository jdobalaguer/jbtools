
function a = glm_within(s,m,o)
    %% b = GLM_WITHIN(s,m,o)
    % Perform a within-subject glm analysis
    % 
    % s : struct            : data
    % m : struct            : model
    % o : struct            : options
    % a : vector of structs : estimation

    %% function
    
    % default
    func_default('o',[]);
    
    % get variables
    x = glm_design(s,m);
    y = glm_target(s,m);
    a = glm_estimation(x,y,o);
end
