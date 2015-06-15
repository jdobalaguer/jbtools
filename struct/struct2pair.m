
function p = struct2pair(s)
    %% p = STRUCT2PAIR(s)
    % create a cell of pairs field/value made corresponding to the struct
    % s : input struct
    % p : resulting cell with pairs {field1,value1,field2,value2,..}
    
    %% function
    f = fieldnames(s);
    v = struct2cell(s);
    p = [mat2row(f);mat2row(v)];
    p = mat2row(p);
end
