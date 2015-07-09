
function m = scan_mvpa_dx_class_glm_training(varargin)
    %% scan = SCAN_MVPA_DX_CLASS_GLM_TRAINING(scan)
    % classifier for mvpa decoding
    % see also scan_mvpa_dx
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    x = varargin{1};
    y = varargin{2};
    p = varargin(3:end);
    
    % numbers
    [u_level,n_level] = numbers(y);
    
    % glmfit
    b = {};
    for i_level = 1:n_level
        target = (y == u_level(i_level));
        b{i_level} = glmfit(x,target,p{:});
    end
    
    %output
    m.u_level = u_level;
    m.b       = b;
    
end
