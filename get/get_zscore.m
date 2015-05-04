
function y = get_zscore(x,s)
    %% [y] = GET_ZSCORE(x,s)
    % z-scored matrix [x], independently for each index in [s]
    
    %% warnings
    
    %% function
    
    % defaults
    default('s',ones(size(x)));
    
    % assert
    assert(isvector(x), 'get_discrete: error. [x] must be a vector.');
    assert(isvector(s), 'get_discrete: error. [s] must be a vector.');
    assertSize(x,s);
    
    % do
    y = nan(size(x));
    [u_s,n_s] = numbers(s);
    for i_s = 1:n_s
        ii_s = (s == u_s(i_s));
        x_s  = x(ii_s);
        m_s = nanmean(x_s);
        v_s = nanstd(x_s,0);
        if ~v_s, y_s = 0;
        else     y_s  = (x_s - m_s) / v_s;
        end
        y(ii_s) = y_s;
    end
end
