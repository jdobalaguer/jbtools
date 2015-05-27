
function r = cellfun2(f,c)
    %% r = CELLFUN2(f,c)
    % like cellfun, but it returns a cell
    
    %% function
    r = cell(size(c));
    for i = 1:numel(c)
        r{i} = f(c{i});
    end
    
end