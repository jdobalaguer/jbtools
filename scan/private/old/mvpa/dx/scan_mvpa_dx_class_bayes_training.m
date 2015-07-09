
function o = scan_mvpa_dx_class_bayes_training(varargin)
    %% scan = SCAN_MVPA_DX_CLASS_BAYES_TRAINING(scan)
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
    m = {};
    e = {};
    for i_level = 1:n_level
        ii_level = (y == u_level(i_level));
        m{i_level} = mean(x(ii_level,:));
        e{i_level} =  std(x(ii_level,:));
    end
    
    %output
    o.m = m;
    o.e = e;
    o.u_level = u_level;
    
end
