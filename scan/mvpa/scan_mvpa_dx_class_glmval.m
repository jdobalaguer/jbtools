
function yfit = scan_mvpa_dx_class_glmval(varargin)
    %% scan = SCAN_MVPA_DX_CLASS_GLMVAL(scan)
    % classifier for mvpa decoding
    % see also scan_mvpa_dx
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    m = varargin{1};
    x = varargin{2};
    p = varargin(3:end);
    
    b       = m.b;
    u_level = m.u_level;
    
    % numbers
    n_sample = size(x,1);
    n_level  = length(u_level);
    
    % glmval
    y = [];
    for i_level = 1:n_level
        y(:,i_level) = glmval(b{i_level},x,p{:});
    end
    
    % find max level
    ymax = repmat(max(y,[],2),[1,n_level]);
    mlev = repmat(u_level',[n_sample,1]);
    
    ii = (y == ymax);
    yfit = sum(mlev .* ii, 2);
    
end
