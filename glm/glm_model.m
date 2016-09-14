
function m = glm_model()
    %% m = GLM_MODEL()
    % Default model for the glm toolbox
    % 
    % m : struct : template with default options

    %% function
    m = struct();
    m.subject     = 'expt_subject'; % split per subject
    m.target      = [];             % target fieldname
    m.regressor   = {};             % regressor fieldnames
    m.model       = [];             % weights for main effect / interactions, see x2fx
    m.zscore      = true;           % z-score regressors and target?
end
