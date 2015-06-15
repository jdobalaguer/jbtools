
function y = getv_scalar(varargin)
    %% y = GETV_SCALAR(m,x1,[,x2][,x3][...])
    % create a vector with a matrix
    % this function reverses functions like getm_mean
    
    %% function
    
    % default
    assert(nargin > 1, 'jb_setvector: error. not enough inputs');
    m = varargin{1};
    x = fliplr(varargin(2:end));
    l = length(x{1});
    
    % assert
    for i=1:nargin-1
        assert(isvector(x) ,    'jb_setvector: error. x(%d) is not a vector',i);
        assert(length(x{i})==l, 'jb_setvector: error. x(%d) has wrong length',i);
    end
    
    % set inputs
    for i=1:nargin-1, x{i} = x{i}(:); end
    x = cell2mat(x);
    
    % numbers
    u = unique(x,'rows','sorted');
    n = size(u,1);
    
    % set values
    y = size(varargin{2});
    for i = 1:n
        row = u(i,:);
        ii = findrow(row,x);
        y(ii) = m(i);
    end
end

%% auxiliar
function ii = findrow(v,m)
    ii = all(repmat(v,size(m,1),1)==m,2);
end