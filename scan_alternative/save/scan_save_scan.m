
function scan = scan_save_scan(scan)
    %% scan = SCAN_SAVE_SCAN(scan)
    % save the [scan] struct
    % to list main functions, try
    %   >> help scan;

    %% function
    file_mkdir(fileparts(scan.running.file.save.scan));
    if bytes(scan) < 2e9
        save(scan.running.file.save.scan,'scan');
    else
        save(scan.running.file.save.scan,'scan','-v7.3');
    end
end
