
function h = fig_pimage(varargin)
    %% h = FIG_PIMAGE(varargin)
    % this works like pcolor. it has the advantage of plotting NaNs as blank cells
    % however, it centers each cell on the value, and doesn't miss the last row/column!
    
    %% warnings
    
    %% function1
    
    % defaults
    switch nargin
        case 1
            C = varargin{1};
            X = 1:size(C,2)+0.5;
            Y = 1:size(C,1)+0.5;
        case 3
            C = varargin{3};
            X = varargin{1} - 0.5;
            Y = varargin{2} - 0.5;
            X(end+1)   = X(end) + 1;
            Y(end+1)   = Y(end) + 1;
        otherwise
            error('fig_pimage: error. wrong number of arguments');
    end
    
    % add an extra thing
    C(end+1,:) = C(end,:);
    C(:,end+1) = C(:,end);
    
    % plot
    h = pcolor(X,Y,C);

end