
function r = cell_mat2vec(c)
    %% r = CELL_FUN(c)
    % apply mat2vec to a cell
    
    %% function
    r = cell_fun(@mat2vec,c);
end
