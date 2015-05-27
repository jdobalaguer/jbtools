
function r = cellfun3(f,c)
    %% r = CELLFUN3(f,c)
    % like cellfun2, but recursively
    
    %% function
    r = cell(size(c));
    for i = 1:numel(c)
        if iscell(c{i})
            r{i} = cellfun3(f,c{i});
        else
            r{i} = f(c{i});
        end
    end
    
end