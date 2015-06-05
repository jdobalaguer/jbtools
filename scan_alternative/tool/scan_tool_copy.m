
function scan_tool_copy(file1,file2)
    %% SCAN_TOOL_COPY(file1,file2)
    % copy a file from [file1] to [file2]
    % if the file has extension ".img", it will also copy the file with extension ".hdr"
    % i
    % file1     : string with the original file (can be a cell of strings)
    % file2     : string with the destination (can be a cell of strings)
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    if ischar(file1) && ischar(file2)
        % check extension
        [~,~,e1] = fileparts(file1);
        [~,~,e2] = fileparts(file2);
        if any(strcmp(e1,{'.img'})) || any(strcmp(e2,{'.img'}))
            % MRI image
            spm_imcalc_ui(file1,file2,'i1');
        else
            % default copy
            copyfile(file1,file2);
        end
    else
        % cell of strings
        assertSize(file1,file2);
        for i = 1:length(file1)
            scan_tool_copy(file1{i},file2{i});
        end
    end
end
