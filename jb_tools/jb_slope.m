
function [slope,intercept] = jb_slope(varargin)
    %% [slope,intercept] = JB_SLOPE([x,]y)
    
    %% warnings
    
    %% function
    switch nargin
        case 1
            y = varargin{1};
            x = 1:length(y);
        case 2
            y = varargin{2};
            x = varargin{1};
        otherwise
            error('jb_slope: error. nargin "%d" must be 1 or 2',nargin);
    end
    
    b = glmfit(x,y,'normal');
    slope     = b(2);
    intercept = b(1);
end