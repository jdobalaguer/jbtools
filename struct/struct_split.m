
function [z,u] = struct_split(s,varargin)
    %% [z,u] = STRUCT_SPLIT(s,f1[,f2][,..])
    % split a struct in mupltiple structs
    
    %% function
    f = varargin;
    assertString(f{:});
    x = cellfun(@(f)s.(f),f,'UniformOutput',false);
    x = [x{:}];
    [u,~,ii] = unique(x,'rows');
    z = arrayfun(@(i)struct_filter(s,ii == i), unique(ii));
end
