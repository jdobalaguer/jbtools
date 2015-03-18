
function [z,u] = getm_func(varargin)
    % [z,u] = getm_func(f,y,x1[,x2][,x3][...])
    
    %% variables
    assert(nargin > 2  , 'getm_func: error. not enough inputs');
    f = varargin{1};
    y = varargin{2};
    x = varargin(3:end);
    l = length(y);
    
    %% assert
    assert(isvector(y) , 'getm_func: error. y is not a vector');
    for i=1:nargin-2
        assert(isvector(x) ,    'getm_func: error. x(%d) is not a vector',i);
        assert(length(x{i})==l, 'getm_func: error. x(%d) has wrong length',i);
    end
    %% set inputs
    y = y(:);
    for i=1:nargin-2, x{i} = double(x{i}(:)); end
    x = cell2mat(x);
    
    %% numbers
    u = unique(x,'rows','sorted');
    n = size(u,1);
    
    %% get values
    z = nan(n,1);
    for i = 1:n
        row = u(i,:);
        ii = findrow(row,x);
        z(i) = f(y(ii));
    end
    
    %% reshape
    if nargout<2
        s = [];
        for i = 1:size(u,2), s(end+1) = length(unique(u(:,i))); end
        s = fliplr(s);
        if isscalar(s), s(end+1)=1; end
        if prod(s) > length(z)
            % complete reshape
            qu = cell(1,size(u,2));
            for i = 1:size(u,2), qu{i} = unique(u(:,i)); end
            qu = jb_allcomb(qu{:});
            qz = nan(size(qu,1),1);
            for i = 1:size(u,1)
                row = u(i,:);
                ii = findrow(row,qu);
                qz(ii) = z(i);
            end
            z = qz;
            u = qu;
        end
        z = reshape(z,s);
        z = permute(z,fliplr(1:length(size(z))));
    end
    
end

function ii = findrow(v,m)
    ii = all(repmat(v,size(m,1),1)==m,2);
end