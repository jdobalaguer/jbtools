
function c = caller(n)
    %% c = CALLER([n])
    % returns the name of the caller function
    
    %% warnings
    
    %% function
    
    % default
    if ~nargin, n = 1; end
    n = n+2; % correction
    
    % get name
    db = dbstack();
    if numel(db)<n, c = '';
    else            c = db(n).name;
    end
end