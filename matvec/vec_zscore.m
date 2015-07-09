
function y = vec_zscore(x,s)
    %% [y] = VEC_ZSCORE(x,s)
    % z-scored matrix [x], independently for each index in [s]
    
    %% function
    
    % default
    func_default('s',ones(size(x)));
    
    % assert
    assertVector(s);
    assertSize(x(:,1),s);
    
    % do
    y = nan(size(x));
    [u_s,n_s] = numbers(s);
    for i_s = 1:n_s
        ii_s = (s == u_s(i_s));
        x_s  = x(ii_s,:);
        m_s = repmat(nanmean(x_s),  [sum(ii_s),ones(1,ndims(x_s)-1)]);
        v_s = repmat(nanstd (x_s,0),[sum(ii_s),ones(1,ndims(x_s)-1)]);
        y_s  = (x_s - m_s) ./ v_s;
        y_s(v_s == 0) = 0;
        y(ii_s,:) = y_s;
    end
end
