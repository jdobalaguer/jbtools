
function z = permat(x,s)
    %% z = permat(x,s)
    % repmat... the other way around!
    % when using numbers/chars x, see also KRON (e.g. kron(x,ones(s)))
    
    %% function
    
    % assign
    n = ndims(x);
    s(end+1:n) = 1;
    z = x;
    
    % inverse repmat
    for i = n:-1:1
        z = reshape(z,[mat_size(z,1:i-1),1,mat_size(z,i:n)]);
        z = repmat(z,[ones(1,i-1),s(i),ones(1,n-i+1)]);
        z = reshape(z,[mat_size(z,1:i-1),prod(mat_size(z,i:i+1)),mat_size(z,i+2:n+1)]);
    end
end
