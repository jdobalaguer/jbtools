
function file = file_match(path,mode)
    %% file = FILE_MATCH(path,mode)
    % find a file that matches a pattern, and return the complete path
    % path : string specifying the pattern
    
    %% function
    func_default('mode','local');
    path = file_nendsep(path);
    list = file_list(path,mode);
    assertWarning(isscalar(list),'file_match: warning. multiple files found. using "%s"',list{1});
    func_default('list',{''});
    file = list{1};
    
end