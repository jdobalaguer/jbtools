
function text = file_read(filename)
    %% text = FILE_READ(filename)
    % read a text file
    
    %% function

    % open
    fid = fopen(filename,'r');
    % check
    if fid<0
        error(['couldn''t open "',filename,'"']);
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