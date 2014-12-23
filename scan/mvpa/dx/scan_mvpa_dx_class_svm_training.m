
function o = scan_mvpa_dx_class_svm_training(varargin)
    %% scan = SCAN_MVPA_DX_CLASS_SVM_TRAINING(scan)
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
    m = {};
    for i_level = 1:n_level
        ii_level = (y == u_level(i_level));
        m{i_level} = svmtrain(x,ii_level,p{:});
    end
    
    %output
    o.m = m;
    o.u_level = u_level;
    
end
