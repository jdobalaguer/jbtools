
function o = scan_mvpa_dx_class_sdt_training(varargin)
    %% scan = SCAN_MVPA_DX_CLASS_SDT_TRAINING(scan)
    % classifier for mvpa decoding
    % see also scan_mvpa_dx
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    x = varargin{1};
    y = varargin{2};
    p = varargin(3:end);
    if isempty(p), p = {'sdt'}; end
    
    % numbers
    [u_level,n_level] = numbers(y);
    
    % glmfit
    m = {};
    e = {};
    for i_level = 1:n_level
        ii_level = (y == u_level(i_level));
        m{i_level} = mean(x(ii_level,:),1);
        switch p{1}
            case 'sdt'
                e{i_level} = std(x(ii_level,:),[],1);
            case 'ones'
                e{i_level} = ones(size(m{i_level}));
            otherwise
                error('scan_mvpa_dx_class_sdt_training: error. mode "%s" unknown',p{1});
        end
                
    end
    
    %output
    o.m = m;
    o.e = e;
    o.u_level = u_level;
    
end
