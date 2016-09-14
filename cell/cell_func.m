
function r = cell_func(varargin)
    %% r = CELL_FUNC(f,c1,c2,...)
    % like cellfun, but recursively
    % it always takes a cell as the output of [f]
    % e.g.
    %   c = cell_fun(@(x,y)x+y,{1,{1,2},3},{1,{1,2},3})
    
    %% notes
    % TODO. automatic unif false?
    
    %% function
    
    % set arguments
    f = varargin{1};
    c = varargin(2:end);
    r = cell(size(c{1}));
    
    % assert
    assertSize(c{:});
    
    % cell loop
    for i = 1:numel(c{1})
        
        % get cell values
        v = cell(1,length(c));
        for j = 1:length(c)
            v{j} = c{j}{i};
        end
        
        % local function
        if all(cellfun(@iscell,v))
            r{i} = cell_func(f,v{:});
        else
            r{i} = f(v{:});
        end
    end
end
