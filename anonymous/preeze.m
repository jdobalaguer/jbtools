
function y = preeze(x,dim)
    %% y = preeze(x,dim)
    
    %% function
    if nargin==1
        y = squeeze(nanprod(x));
    else
        y = x;
        n = length(dim);
        for i=1:n,
            y = nanprod(y,dim(i));
        end
        y = squeeze(y);
    end
end