
function color = fig_colormap(v,scheme,r)
    %% color = fig_colormap(v,scheme,r)
    % get color schemes (in the range [0,1])
    
    %% function
    
    % default
    v = mat2vec(v);
    func_default('scheme','parula');
    func_default('r',     ranger(v));
    n = 101;
    
    % get colormap
    c = fig_color(scheme,n);
    f = 1 + round((n-1) .* (v - r(1)) ./ (r(2) - r(1)));
    f(f<1) = 1;
    f(f>n) = n;
    color = c(f,:);
end
