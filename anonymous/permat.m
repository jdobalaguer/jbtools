
function z = permat(varargin)
    %% Z = permat(X,S)
    % repmat... the other way around!
    
    %% warnings
    
    %% function
    
    % assign
    x = varargin{1};
    n = ndims(x);
    s = varargin{2};
    s(end+1:n) = 1;
    z = x;
    
    % inverse repmat
    for i = n:-1:1
        z = reshape(z,[sizep(z,1:i-1),1,sizep(z,i:n)]);
        z = repmat(z,[ones(1,i-1),s(i),ones(1,n-i+1)]);
        z = reshape(z,[sizep(z,1:i-1),prod(sizep(z,i:i+1)),sizep(z,i+2:n+1)]);
    end
    
end