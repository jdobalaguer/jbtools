function varargout = shuffle(varargin)
    %% [x1,x2,..] = shuffle(x1,x2,..)
    
    %% function
    
    % defaults
    n_argin  = nargin();
    n_argout = nargout();
    if ~n_argout
        n_argout = 1;
    end
    varargout = varargin;
    
    % assert
    assert(n_argin==n_argout, 'shuffle: error. number of inputs and outputs doesnt match');
    for i_argin = 1:n_argin
        assert(isvector(varargin{i_argin}),'shuffle: error. x(%d) is not a vector',i_argin);
    end
    for i_argin = 1:n_argin
        assert(length(varargin{1})==length(varargin{i_argin}),'shuffle: error. x(%d) wrong length',i_argin);
    end
    
    % shuffled index
    ii = randperm(length(varargin{1}));
    
    % shuffle
    for i_argin = 1:n_argin
        varargout{i_argin} = varargin{i_argin}(ii);
    end
end
