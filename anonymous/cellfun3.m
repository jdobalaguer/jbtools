
function r = cellfun3(varargin)
    %% r = CELLFUN3(f,c1,c2,...)
    % like cellfun2, but recursively
    % example: c = cellfun3(@(x,y)x+y,{1,{1,2},3},{1,{1,2},3})
    
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
            r{i} = cellfun3(f,v{:});
        else
            r{i} = f(v{:});
        end
    end
    
end