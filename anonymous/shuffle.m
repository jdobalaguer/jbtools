
function varargout = shuffle(varargin)
    %% [x1,x2,..] = shuffle(x1,x2,..)
    % shuffle multiple vectors of same size consistently
    
    %% function
    
    % assert
    assertVector(varargin{:});
    assertSize(varargin{:});
    
    % shuffled index
    ii = randperm(length(varargin{1}));
    
    % shuffle
    varargout = cell(1,nargin);
    for i = 1:nargin
        varargout{i} = varargin{i}(ii);
    end
end
