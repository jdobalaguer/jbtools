
function path = file_2local(path)
    %% path = FILE_2LOCAL(path)
    % transform path to "local"
    
    %% function
    [~,n,e] = fileparts(path);
    path = strcat(n,e);
end
