
% b = JB_BINARYTABLE(n)
% returns a matrix with all possible binary vectors of length n.

%% function
function b = jb_binarytable(n)
    b = [0;1];
    for i_action = 2:n
        s = size(b,1);
        b = [zeros(s,1) , b ; ones(s,1) , b];
    end
end