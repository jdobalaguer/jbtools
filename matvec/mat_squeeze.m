
function y = mat_squeeze(x,d)
    %% y = MAT_SQUEEZE(x[,d])
    % squeeze dimensions [d] if possible
    % x : matrix. input to be be squeezed
    % d : vector. defines the dimensions to squeeze
    % y : matrix. output
    
    %% function
    
    % default
    func_default('d',vec_filter(1:ndims(x),@(i)mat_size(x,i)==1));
    
    % assert
    s = size(x);
    s(end+1:max(d)) = 1;
    func_assert(all(s(d)==1),'one or more dimensions have size ~= 1');
    
    % squeeze
    s(d) = [];
    y = mat_reshape(x,s);
end
