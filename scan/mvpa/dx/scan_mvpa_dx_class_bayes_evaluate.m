
function yfit = scan_mvpa_dx_class_bayes_evaluate(varargin)
    %% scan = SCAN_MVPA_DX_CLASS_BAYES_EVALUATE(scan)
    % classifier for mvpa decoding
    % see also scan_mvpa_dx
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    % input
    o = varargin{1};
    x = varargin{2};
    p = varargin(3:end);
    
    m       = o.m;
    e       = o.e;
    u_level = o.u_level;
    
    % numbers
    n_level  = length(u_level);
    n_sample = size(x,1);
    
    % distance
    p = nan(n_sample,n_level);
    for i_level = 1:n_level
        mat_m = repmat(m{i_level},[n_sample,1]);
        mat_e = repmat(e{i_level},[n_sample,1]);
        mat_p = normpdf(x,mat_m,mat_e);
        p(:,i_level) = mean(log(mat_p),2);
    end
    
    % find max level
    pmax = repmat(max(p,[],2),[1,n_level]);
    mlev = repmat(u_level',[n_sample,1]);

    ii = (p == pmax);
    yfit = sum(mlev .* ii, 2);
    
end
