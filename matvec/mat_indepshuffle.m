
function z = mat_indepshuffle(x,d)
    %% z = MAT_INDEPSHUFFLE(x,d)
    % x : vector/matrix to shuffle
    % d : dimension
    % z : resulting shuffle
    
    %% function
    
    % dimension specific
    s = size(x);
    i = arrayfun(@(s)ones(1,s),s,'UniformOutput',false);
    i{d} = s(d);
    z = mat2cell(x,i{:});
    z = cellfun(@mat_shuffle,z,'UniformOutput',false);
    z = cell2mat(z);
    
end
