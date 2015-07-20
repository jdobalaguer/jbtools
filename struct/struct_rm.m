
function s = struct_rm(varargin)
    %% s = STRUCT_RM(s,f1[,f2][,..])
    % remove fields {f} to [s]
    % (this doesn't throw any warnings)
    
    %% function
    [s,f] = deal(varargin{1},varargin(2:end));
    for i = 1:length(f)
        if isfield(s,f{i})
            s = rmfield(s,f{i});
        end
    end
end
