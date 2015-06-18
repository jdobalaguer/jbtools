
function [z,u] = getm_all(varargin)
    %% [z,u] = GETM_ALL(y,x1[,x2][,..])
    % get cell [z] with all y values per each combination [u] of the regressors {x}
    % y : can be a matrix of size [n*l]
    % x : vectors of regressors
    
    %% note
    % 1. the permute bit specifically fails when the first dimension has length 1..
    % 2. it's not robust to NaN
    
    %% function
    
    
    % variables
    y = varargin{1};
    x = varargin(2:end);
    l = length(y);
    
    % columns & rows
    if isvector(y), y = mat2vec(y); end
    x = cellfun(@mat2vec,x,'UniformOutput',false);
    
    % assert
    assertVector(y(:,1),x{:});
    assertSize(y(:,1),x{:});
    
    % set inputs
    if isvector(y), y = mat2vec(y); end
    x = cellfun(@double, x,'UniformOutput',false);
    x = cellfun(@mat2vec,x,'UniformOutput',false);
    x = cell2mat(x);
    
    % numbers
    u = unique(x,'rows','sorted');
    n = size(u,1);
    
    % get values
    z = cell(n,1);
    for i = 1:n
        row = u(i,:);
        ii = findrow(row,x);
        z{i} = y(ii,:);
    end
    
    % reshape
    s = [];
    for i = 1:size(u,2), s(end+1) = length(unique(u(:,i))); end
    s = fliplr(s);
    if isscalar(s), s(end+1)=1; end
    if prod(s) > numel(z)
        % complete reshape
        qu = cell(1,size(u,2));
        for i = 1:size(u,2), qu{i} = unique(u(:,i)); end
        qu = vec_combination(qu{:});
        qz = cell(size(qu,1),1);
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

function ii = findrow(v,m)
    ii = all(repmat(v,size(m,1),1)==m,2);
end