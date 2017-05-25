
function z = vec_repsample(x,k)
    %% z = VEC_REPSAMPLE(x,k)
    % sample [k] values from a vector, with replacement
    % x : vector. values from where to sample
    % k : scalar. number of values to sample
    
    %% note
    % this function replaces @randsample, that seems to be unreliable.
    % if you run >> randsample(2,1)
    % you may get the output 1.
    % with this function, [x] is always the vector of values
    % and [k] is always a scalar with the number of samples

    %% function
    func_default('k',1);
    assertVector(x);
    n  = numel(x);
    ii = randi(n,1,k);
    z  = x(ii);
end
