
function b = struct_isempty(s)
    %% b = STRUCT_ISEMPTY(s)
    % is the struct empty?
    
    %% function
    b = isempty(fieldnames(s));
end
