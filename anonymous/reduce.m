function r = reduce(f,varargin)
    %% r = REDUCE(f,varargin)
    % reduce analog of python's function

    %% notes
    % based on "http://stackoverflow.com/questions/29875376/matlab-equivalent-of-pythons-reduce-function"
    
    %% function
    while numel(varargin)>1
        varargin{end-1} = f(varargin{end-1},varargin{end});
        varargin(end) = [];
    end
    r = varargin{1};
end
