function y = meeze(x,dim)
    %% y = meeze(x,dim)
    
    %% function
    if nargin==1
        y = squeeze(nanmean(x));
    else
        y = x;
        n = length(dim);
        for i=1:n,
            y = nanmean(y,dim(i));
        end
        y = squeeze(y);
    end
end