
function assertUnix(msg)
    %% ASSERTUNIX(msg)

    
    %% warnings
    
    %% function
    if ~nargout,
        msg = 'this function only works in unix';
    end
    db = dbstack();
    if ~isscalar(db), db(1) = []; end
    assert(isunix(), '%s: error. %s',db(1).name,msg);
end