function b = jb_and(varargin)
    %% b = JB_AND(x1,x2,x3...)
    % like AND, but with illimited inputs
    % x : conditions
    % b : resulting boolean
    
    %% function
    
    % assert
    assertSize(varargin{:});
    
    % extended and
    b = true(size(varargin{1}));
    for i = 1:nargin
        b = and(b,varargin{i});
    end
end
    