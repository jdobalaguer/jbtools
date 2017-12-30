
function file_copy(source,destination)
    %% FILE_COPY(source,destination)
    % like copyfile, but source/destination can be a cell too
    
    %% function
    switch [class(source),':',class(destination)]
        case 'cell:cell', cellfun(@(s,d)file_copy(s,d),source,destination,'UniformOutput',false);
        case 'cell:char', cellfun(@(s)file_copy(s,destination),source,'UniformOutput',false);
        case 'char:char', copyfile(source,destination);
        otherwise         func_error('[source] is of class %d',class(source));
    end
end
