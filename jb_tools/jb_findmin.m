
function [f,v] = jb_findmin(m)
    %% f = JB_FINDMIN(m)
    % finds the indices [f(i,:)] of the global minima in matrix [m]
    
    %% warning
    
    %% function
    
    % grids
    s = mat_size(m);
    n_x = length(s);
    u_x = cell(1,n_x);
    for i = 1:n_x, u_x{i} = 1:size(m,i); end
    [g_x{1:n_x}] = ndgrid(u_x{:});
    
    % convert to vector
    v = mat2vec(m);
    
    % find minima
    v_min = nanmin(v);
    f_min = find(v == v_min);
    n_min = length(f_min);
    
    % find corresponding x
    x_min = nan(0,n_x);
    for i_min = 1:n_min
        x_min(i_min,:) = nan;
        for i_x = 1:n_x
            x_min(i_min,i_x) = g_x{i_x}(f_min(i_min));
        end
    end
    
    % return
    f = x_min;
    v = v_min;
    
end