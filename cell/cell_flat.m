
function q = cell_flat(c)
    %% q = CELL_FLAT(c)
    % make cell flat
    
    %% warnings
    %#ok<*AGROW>
    
    %% function
    assert(iscell(c), 'cell_flat: error. c not a cell');
    q = flatten(c);
end

%% auxiliar
function q = flatten(c)
    if ~iscell(c), q = {c}; return; end
    
    q = {};
    for i = 1:numel(c)
        q = [q,flatten(c{i})];
    end
end
