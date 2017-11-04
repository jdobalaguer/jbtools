
function x = empty2nan(x)
    %% x = EMPTY2NAN(x)
    % replace empty values with nans
    
    %% function
    
    % cell
    if iscell(x), x(cellfun(@isempty,x)) = {nan}; return; end
    
    % vector / matrix
    if isempty(x), x = nan; return; end
end
