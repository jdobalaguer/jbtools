function b = jb_or(varargin)
    %% b = JB_OR(x1,x2,x3...)
    % like OR, but with illimited inputs
    % x : conditions
    % b : resulting boolean
    
    %% function
    
    % assert
    assertSize(varargin{:});
    
    % extended and
    b = false(size(varargin{1}));
    for i = 1:nargin
        b = or(b,varargin{i});
    end
end
    