
function y = steeze(x,dim)
    %% y = steeze(x,dim)
    
    %% function
    if isrow(x), x = mat2vec(x); end
    if nargin==1
        y = squeeze(nanste(x));
        if isvector(y), y = mat2vec(y); end
    else
        y = x;
        n = length(dim);
        for i=1:n,
            y = nanste(y,dim(i));
        end
        y = squeeze(y);
        if isvector(y), y = mat2vec(y); end
    end
end
