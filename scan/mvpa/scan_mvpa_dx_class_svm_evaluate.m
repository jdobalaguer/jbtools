
function yfit = scan_mvpa_dx_class_svm_evaluate(varargin)
    %% scan = SCAN_MVPA_DX_CLASS_SVM_EVALUATE(scan)
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
    u_level = o.u_level;
    
    % numbers
    n_level  = length(u_level);
    n_sample = size(x,1);
    
    % classify test cases
    t_fit = [];
    for i_level = 1:n_level
        t_fit(:,i_level) = svmclassify(m{i_level},x,p{:});
    end
    t_fit = t_fit + 0.01*randn(size(t_fit));

    % find max level
    t_max = repmat(max(t_fit,[],2),[1,n_level]);
    mlev = repmat(u_level',[n_sample,1]);

    ii = (t_fit == t_max);
    yfit = sum(mlev .* ii, 2);
    
end
