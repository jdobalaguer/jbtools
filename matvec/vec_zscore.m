
function y = vec_zscore(x,s)
    %% [y] = VEC_ZSCORE(x,s)
    % z-scored matrix [x], independently for each index in [s]
    
    %% function
    
    % default
    func_default('s',ones(size(x)));
    
    % assert
    assertVector(x);
    assertVector(s);
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
