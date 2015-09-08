
function z = vec_func(varargin)
    %% z = VEC_FUNC(f,y,x)
    % apply a function [f] to {x} and {y} independently for each combination of {x}
    % f :  a function @(y,x). it should return either a scalar or a vector
    % y : value (cell of matrix)
    % x : index (cell of vectors)
    % z : resulting vector
    
    %% notes
    % a current limitation. the resulting vector can only be a vector or a matrix (never a tensor)
    
    %% function
    
    % assert
    assert(nargin>1,'vec_func: error. not enough arguments');
    assert(nargin<4,'vec_func: error. too many arguments');
    
    % default
    varargin(end+1:3) = {{}};
    f = varargin{1};
    y = varargin{2};
    x = varargin{3};
    
    % assert
    assertVector(x{:});
    func_return(@assertSize,0,[x,cellfun(@(y)y(:,1),y,'UniformOutput',false)]);
    
    % apply
    z = apply(f,y,x,{});
end

%% recursive function
function z = apply(f,y,x,u)
    % instead of using @unique('rows'), we do it recursively
    % that way, using @isequal we can compare pretty much anything (even nans)
    % x : remaining x to index
    % y : y matching those x
    % u : x values already indexed
    if isempty(x), z = f(y,u); return; end
%     z = nan(size(x{1}));
    ux = unique(x{1});
    for ix = 1:length(ux)
        ii = arrayfun(@(x)isequaln(x,ux(ix)),x{1});
        tx = cellfun(@(x)x(ii),  x(2:end),'UniformOutput',false);
        ty = cellfun(@(y)y(ii,:),y,       'UniformOutput',false);
        tu = cellfun(@(u)u(ii),  u,       'UniformOutput',false);
        tu{end+1} = x{1}(ii); %#ok<AGROW>
        z(ii,:) = apply(f,ty,tx,tu); %#ok<AGROW>
    end
end
