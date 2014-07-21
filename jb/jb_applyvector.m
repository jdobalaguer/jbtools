
function y = jb_applyvector(varargin)
    % [y] = jb_applyvector(f,x1[,x2][,x3][...])
    
    %% defaults
    f = varargin{1};
    x = varargin(2:end);
    
    %% assert
    assert(nargin>1,                        'jb_applyvector: error. not enough arguments');
    for i = 1:length(x)
        assert(isvector(x{i}),              'jb_applyvector: error. x(%d) is not a vector', i);
        assert(~any(isnan(x{i})),           'jb_applyvector: error. x(%d) contains nans',   i);
        assert(length(x{i})==length(x{1}),  'jb_applyvector: error. x(%d) has wrong length',i);
    end
    
    %% apply
    y = apply(f,x,[]);
    
    %% recursive function
    function y = apply(f,xs,us)
        if isempty(xs), y = f(us{:}); return; end
        y = nan(size(xs{1}));
        for ux = unique(xs{1})
            ii = (xs{1} == ux);
            y(ii) = apply(f,cellfun(@(x)x(ii),xs(2:end),'UniformOutput',false),[us,{ux}]);
        end
    end

end

