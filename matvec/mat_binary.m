

function m = mat_binary(n)
    %% m = MAT_BINARYTABLE(n)
    % create a matrix with all possible binary vectors of length n.
    % n : number of columns
    % m : logical matrix of size [2^n,n]

    %% function
    m = [false;true];
    for i_action = 2:n
        s = size(m,1);
        m = [false(s,1) , m ; true(s,1) , m];
    end
end
