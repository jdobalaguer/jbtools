
function y = vec_func(varargin)
    %% y = VEC_FUNC(f,x1[,x2][,x3][...])
    % apply a function [f] independently for each combination of {x}
    % f :  a function @(i1,i2,...) that returns either a scalar or a vector
    % x : combinations
    % y : resulting vector
    
    %% function
    
    % default
    f = varargin{1};
    x = varargin(2:end);
    
    % assert
    assert(nargin>1,'vec_func: error. not enough arguments');
    assertVector(x);
    assertNan(x{:});
    assertSize(x{:});
    
    % apply
    y = apply(f,x,[]);
end

%% recursive function
function y = apply(f,xs,us)
    if isempty(xs), y = f(us{:}); return; end
    y = nan(size(xs{1}));
    for ux = unique(xs{1})
        ii = (xs{1} == ux);
        y(ii) = apply(f,cellfun(@(x)x(ii),xs(2:end),'UniformOutput',false),[us,{ux}]);
    end
end
