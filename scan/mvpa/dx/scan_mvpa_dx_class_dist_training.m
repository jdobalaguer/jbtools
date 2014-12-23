
function o = scan_mvpa_dx_class_dist_training(varargin)
    %% scan = SCAN_MVPA_DX_CLASS_DIST_TRAINING(scan)
    % classifier for mvpa decoding
    % see also scan_mvpa_dx
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    x = varargin{1};
    y = varargin{2};
    p = varargin(3:end);
    if isempty(p), p = {}; end
    
    % numbers
    [u_level,n_level] = numbers(y);
    
    % glmfit
    patterns = {};
    for i_level = 1:n_level
        ii_level = (y == u_level(i_level));
        patterns{i_level} = x(ii_level,:);
    end
    
    %output
    o.patterns = patterns;
    o.u_level = u_level;
    
end
