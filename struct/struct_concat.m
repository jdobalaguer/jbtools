function ret = struct_concat(varargin)
    %% s = STRUCT_CONCAT(dim,s1,s2,..)
    % concat many structs
    
    %% warnings
    
    %% function
    dim = varargin{1};
    ret = varargin{2};
    for i_struct = 3:length(varargin)
        ret = struct_concat_two(dim, ret , varargin{i_struct});
    end
end

%% AUXILIAR: concat two structs
function ret = struct_concat_two(dim,s1,s2)
    if isempty(s2), ret  = s1; return; end
    
    u_field = fieldnames(s1);
    nb_fields = length(u_field);
    
    ret = struct();
    for i_field = 1:nb_fields
        this_field = u_field{i_field};
        % get values
        v1 = s1.(this_field);
        v2 = s2.(this_field);
        % convert to cell
        if ~strcmp(class(v1),class(v2))
            if ~iscell(v1); v1={v1}; end
            if ~iscell(v2); v2={v2}; end
        end
        if ischar(v1),   v1 = {v1}; end
        if ischar(v2),   v2 = {v2}; end
        % concat values
        v = cat(dim,v1,v2);
        % save value
        ret.(this_field) = v;
    end
end