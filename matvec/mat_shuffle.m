
function z = mat_shuffle(x,d)
    %% z = MAT_SHUFFLE(x[,d])
    % x : vector/matrix to shuffle
    % d : dimension. if none specified, global shuffle will be used
    % z : resulting shuffle
    
    %% function
    
    % default
    func_default('d',[]);
    
    % global de-meaning
    if isempty(d)
        ii = randperm(numel(x));
        z  = reshape(x(ii),size(x));
    % dimension specific
    else
        ii    = arrayfun(@(n)1:n,size(x),'UniformOutput',false);
        ii{d} = randperm(size(x,d));
        z = x(ii{:});
    end
end
