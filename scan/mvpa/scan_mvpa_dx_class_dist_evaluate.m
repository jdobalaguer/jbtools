
function yfit = scan_mvpa_dx_class_dist_evaluate(varargin)
    %% scan = SCAN_MVPA_DX_CLASS_DIST_EVALUATE(scan)
    % classifier for mvpa decoding
    % see also scan_mvpa_dx
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    % input
    o = varargin{1};
    x = varargin{2};
    p = varargin(3:end);
    
    patterns = o.patterns;
    u_level  = o.u_level;
    
    % numbers
    n_level  = length(u_level);
    n_sample = size(x,1);
    
    % distance
    d = nan(n_sample,n_level);
    for i_level = 1:n_level
        n_pattern = size(patterns{i_level},1);
        pattern_d = nan(n_sample,n_pattern);
        for i_pattern = 1:n_pattern
            mat_m = repmat(patterns{i_level}(i_pattern,:),[n_sample,1]);
            mat_d = (x - mat_m);
            pattern_d(:,i_pattern) = mean(power(mat_d,2),2);
        end
        d(:,i_level) = mean(pattern_d,2);
    end
    
    % find max level
    dmin = repmat(min(d,[],2),[1,n_level]);
    mlev = repmat(u_level',[n_sample,1]);

    ii = (d == dmin);
    yfit = sum(mlev .* ii, 2);

    
end
