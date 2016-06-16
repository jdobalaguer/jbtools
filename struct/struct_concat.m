
function s = struct_concat(varargin)
    %% s = STRUCT_CONCAT(d,s1[,s2],..)
    % concatenate many structs, field by field
    % d  : dimension of concatenation
    % s# : structs with same fieldnames
    % s  : resulting struct
    
    %% function
    
    % dimension
    d = varargin{1};
    
    % fieldnames
    f = cellfun(@fieldnames, varargin(2:end),'UniformOutput',false);
    assert(isequal(f{:}),'struct_concat: error. structs have different fieldnames');
    f = f{1};
    
    % values
    v = cellfun(@struct2cell,varargin(2:end),'UniformOutput',false);
    
    % number
    n_f = length(f);
    
    % concatenation
    s = struct();
    for i_f = 1:n_f
        t_f = f{i_f};
        t_v = cellfun(@(x)x{i_f},v,'UniformOutput',false);
        try
            s.(t_f) = cat(d,t_v{:});
        catch
            s.(t_f) = t_v;
        end
    end
end
