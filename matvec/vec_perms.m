

function m = vec_perms(x,k)
    %% m = GETM_PERMS(x,k)
    % return a matrix with all possible combinations of [x]
    % with only [k] columns, and sampling without return
    % 
    % this is equivalent to but more efficient than
    % >> m = unique(perms(x),'rows');
    % >> m = m(:,1:k);
    
    % numbers
    u = unique(x)';
    p = arrayfun(@(u)sum(u==x),u);
    m = auxiliar(u,p,k);
end

%% auxliliar (recursive) function
function m = auxiliar(u,p,k)

    % numbers
    u = u(p>0);
    p = p(p>0);
    n = length(p);

    if k==1
        % last position
        m = u;
    else
        % otherwise
        m = cell(n,1);
        for i = 1:n
            new_u = u;
            new_p = p - ((1:n)==i)';
            new_k = k-1;
            m{i} = auxiliar(new_u,new_p,new_k);
            m{i}(:,end+1) = u(i);
        end
        m = cat(1,m{:});
    end
end