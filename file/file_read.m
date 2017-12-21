
function text = file_read(path)
    %% text = FILE_READ(path)
    % read a text file
    
    %% function

    % open
    fid = fopen(path,'r');
    % check
    if fid<0
        error(['couldn''t open "',path,'"']);
    end
    
    % read
    text = {};
    i = 1;
    while ~feof(fid)
        text{i} = fgetl(fid);
        i = i+1;
    end
    
    % close
    fclose(fid);
end