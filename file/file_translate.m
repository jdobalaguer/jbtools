
function path = file_translate(path)
    %% path = FILE_TRANSLATE(path,mode)
    % 
    
    %% function
    
    switch mode
        case 'relative'
            path = file_2relative(path);
        case 'absolute'
            path = file_2absolute(path);
        case 'local'
            path = file_2local(path);
    end
    
end