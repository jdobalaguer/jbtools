
function y = vec_xval(x,s,c,f,min_s)
    %% [y] = VEC_XVAL(x,s,c[,f][,min_s])
    % do cross-validation
    % [x] vector. input 
    % [y] vector. output 
    % [c] vector. conditions, for which the cross-validation is performed independently
    % [s] vector. subjects, across which the cross-validation is performed
    
    %% function
    
    % default
    func_default('f',@(x)nanmean(x,1));
    func_default('min_s',1);
    
    % assert
    assertVector(c,s);
    assertSize(c,s);
    
    % numbers
    ii = ~isnan(c) & ~isnan(s);
    [u_c,n_c] = numbers(c(ii));
    [u_s,n_s] = numbers(s(ii));
    
    % do
    y = nan(size(x));
    for i_c = 1:n_c
        for i_s = 1:n_s
            
            % indices
            ii_s = (s == u_s(i_s));
            ii_c = (c == u_c(i_c));
            
            if ~sum(ii_s & ii_c), continue; end
            
            % criterion for cross-validation
            if (sum(getm_sum(~ii_s & ii_c,s)>0) < min_s), continue; end
            
            % cross-generalise
            y(ii_s & ii_c,:) = repmat(f(x(~ii_s & ii_c,:)),[sum(ii_s & ii_c),1]);
        end
    end
end
