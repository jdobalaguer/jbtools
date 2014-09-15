
function y = jb_displace(x,n,r,d)
    % y = JB_DISPLACE(x,n[,r][,d])
    %
    % x = original vector
    % n = displacement
    % r = blocks index  (default single block)
    % d = fill-in value (default nan)
    % y = displaced vector
    
    %% warnings
    
    %% defaults
    if ~exist('r','var') || isempty(r), r = ones(size(x)); end
    if ~exist('d','var') || isempty(d), d = nan;           end
    
    %% assert
    assert(isvector(x),'jb_displace: error. x is not a vector');
    assert(numel(n)==1,'jb_displace: error. n should be a single number');
    assert(isvector(r),'jb_displace: error. r is not a vector');
    assert(numel(d)==1,'jb_displace: error. r should be a single number');
    
    %% function
    y = jb_applyvector(@displace,r);
    
    function t = displace(v)
        ii = (r == v);
        t = x(ii);
        if abs(n)<length(t),
            if n>0, t = [ repmat(d,[1,n]) , t(1:end-n)       ]; end
            if n<0, t = [ t(-n+1:end)     , repmat(d,[1,-n]) ]; end
        else
            t = repmat(d,size(t));
        end
    end
end