
function y = seeze(x,dim)
    %% y = seeze(x,dim)
    
    %% function
    if nargin==1
        y = squeeze(nansum(x));
    else
        y = x;
        n = length(dim);
        for i=1:n,
            y = nansum(y,dim(i));
        end
        y = squeeze(y);
    end
end