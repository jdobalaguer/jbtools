
function z = vec_randsample(x,k)
    %% z = VEC_RANDSAMPLE(x,k)
    % replacement function for @randsample, that seems to be unreliable.
    % if you run >> randsample(2,1)
    % you may get the output 1.
    % with this function, [x] is always the vector of values
    % and [k] is always a scalar with the number of samples

    %% function
    assertVector(x);
    n  = numel(x);
    ii = randperm(n);
    z  = x(ii(1:k));
end
