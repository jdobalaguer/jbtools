
function path = file_osfix(path)
    %% path = FILE_OSFIX(path)
    % fix path to the current OS (windows/unix)
    % path : string, or cell of strings
    
    %% function
    switch class(path)
        case 'char'
            path(path == '/') = filesep();
            path(path == '\') = filesep();
        case 'cell'
            for i = 1:numel(path)
                path{i} = file_fix(path{i});
            end
    end

end