
function s = strcat(varargin)
    % STRCAT rebuild
    % strcat([dim, ]S1, S2, ..., SN)
    % + [dim] argument added.
    % + doesnt trim strings automatically
    
    %% warnings
    %#ok<*ERTAG>
    
    %% function
    
    % parse arguments
    if isnumeric(varargin{1})
        dim = varargin{1};
        varargin(1) = [];
    else
        dim = 2;
    end
    nargin = length(varargin);
    
    % assert
    assert(iscellstr(varargin),'strcat: error. arguments must be strings');
    
    % expand strings
    if dim == 1,
        l = max(cellfun(@(s)length(s),varargin));
        for i = 1:nargin
            t = varargin{i};
            t(end+1 : l) = ' ';
            varargin{i} = t;
        end
    end
    
    if dim == 2,
        h = max(cellfun(@(s)size(s,1), varargin));
        for i = 1:nargin
            t = varargin{i};
            if size(t,1) == 1
                t = repmat(t,[h,1]);
            end
            varargin{i} = t;
        end
    end

    % concatenate strings
    switch dim
        case 1
            s = vertcat(varargin{:});
        case 2
            s = horzcat(varargin{:});
        otherwise
            error('strcat: error. wrong dimension');
    end
end


